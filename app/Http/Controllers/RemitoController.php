<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use TCG\Voyager\Facades\Voyager;
use Yajra\DataTables\DataTables;
use App\Almacenes\Model\RemitoLinea;
use App\Almacenes\Actions\PrintAction;
use Endroid\QrCode\ErrorCorrectionLevel;
use Endroid\QrCode\LabelAlignment;
use Endroid\QrCode\QrCode;
use App\Almacenes\Model\Deposito;
use Illuminate\Support\Carbon;
use App\Almacenes\Model\Remito;
use App\Almacenes\Model\Presentacion;

class RemitoController extends EntidadConDetalleController
{
    public function specifyActions() {
        parent::specifyActions();
        Voyager::addAction(PrintAction::class);
    }

    private function getDepositoPorPuntoVenta($puntoVenta) {
        return Deposito::where('punto_venta', $puntoVenta)->firstOrFail();
    }

    // Logica para generar el nro de remito dependiendo del tipo y deposito
    private function generarNumeroRemito($tipo, $depositoId) {
        $ultimoNroRemito = Remito::where('tipo', $tipo)->where('deposito_id', $depositoId)->max('numero');
        return $ultimoNroRemito == null ? 1 : $ultimoNroRemito + 1;
    }
    private function generarPvtaNumeroRemito($tipo, $depositoId) {
        $deposito = Deposito::findOrFail($depositoId);
        return [
            'puntoVenta' => $deposito->punto_venta,
            'numero' => $this->generarNumeroRemito($tipo, $depositoId)
        ];
    }

    // Función para inicializar la entidad (Remito)
    protected function initContent($dataTypeContent) {
        $dataTypeContent->tipo = config('app.almacenes.remito_por_defecto');
        $dataTypeContent->deposito_id = $this->getDepositoPorPuntoVenta(config('app.almacenes.punto_venta_por_defecto'))->id;
        $dataTypeContent->fecha = Carbon::now();
    }

    // Especializada de voyager
    public function preSaveData($data)
    {
        // Si no es REMITO_ENTRADA y no se generó el nro --> hay que generar el nro al grabar
        if($data->tipo != 'REMITO_ENTRADA' && $data->punto_venta == null && $data->numero == null) {
            $numero = $this->generarPvtaNumeroRemito($data->tipo, $data->deposito_id);
            $data->punto_venta = $numero['puntoVenta'];
            $data->numero = $numero['numero'];
        }
    }

    public function print(Request $request, $id) {
        // Traemos remito con relaciones eager
        $remito = Remito::with(
            'depositoId',
            'depositoId.ciudadId',
            'destinatarioId',
            'destinatarioId.ciudadId',
            'detalle',
            'detalle.articulo')->findOrFail($id);
        $detalle = [];
        foreach ($remito->detalle->all() as $item) {
            array_push($detalle, [
                'codigo' => $item->articulo->codigo,
                'articulo' => $item->articulo->nombre,
                'cantidad' => $item->cantidad
            ]);
        }

        // Armamos arreglo de datos con info que se usara en el reporte
        $data = [
            'remito' => [
                'tipo' => $remito->tipo,
                'numero' => str_pad($remito->depositoId->punto_venta, 3, '0', STR_PAD_LEFT)."-".str_pad($remito->numero, 3, '0', STR_PAD_LEFT),
                'fecha' => \DateTime::createFromFormat('Y-m-d', $remito->fecha)->format('d/m/Y'),
                'depositoDireccion' => $remito->depositoId->direccion." ".$remito->depositoId->ciudadId->nombre,
                'depositoTelefono' => $remito->depositoId->telefono,
                'destinatario' => $remito->destinatarioId->nombre,
                'destinatarioDireccion' => $remito->destinatarioId->direccion." ".$remito->destinatarioId->ciudadId->nombre,
                'nota' => "El envio consta de ".(is_null($remito->cantidad_bultos)?"0":$remito->cantidad_bultos)." bultos, ".(is_null($remito->peso)?"0":$remito->peso)." Kg y ".(is_null($remito->volumen)?"0":$remito->volumen)." m3. Precintos N°: ".(is_null($remito->precintos)?"":$remito->precintos)." ".(is_null($remito->nota)?"":$remito->nota),
                'transportador' => $remito->transportador,
                'patente' => $remito->patente,
                'conductor' => $remito->conductor,
                'conductorDNI' => $remito->dni,
                'conductorTel' => $remito->telefono,
                'detalle' => $detalle
            ]
        ];
        $data['remito']['qr'] = $this->generateQR($data);
        // Codificamos como json
        $jsondata = json_encode($data, JSON_PRETTY_PRINT);
        // Grabamos en disco misma ubicación que el reporte
        $data_file = $this->getReportPath() . '/remito.json';
        file_put_contents($data_file, $jsondata);

        // Armamos opciones para jasper
        $options = [
            'format' => ['pdf'],
            'locale' => 'es',
            'params' => [
                'REPORT_DIR' => $this->getReportPath()
            ],
            'db_connection' => [
                'driver' => 'json',
                'data_file' => $data_file,
                'json_query' => 'remito'
            ]            
        ];
        $jasperName = 'remito';
        $downloadName = sprintf("Remito %s.pdf", $remito->numero);
        return $this->printJasperToPDF($jasperName, $options, $downloadName);
    }

    private function generateQR($data) {
        // Create a basic QR code
        $qrCode = new QrCode($data['remito']['numero']);
        $qrCode->setSize(100);

        // Set advanced options
        $qrCode->setWriterByName('png');
        $qrCode->setMargin(10);
        $qrCode->setEncoding('UTF-8');
        $qrCode->setErrorCorrectionLevel(ErrorCorrectionLevel::HIGH);
        $qrCode->setForegroundColor(['r' => 0, 'g' => 0, 'b' => 0, 'a' => 0]);
        $qrCode->setBackgroundColor(['r' => 255, 'g' => 255, 'b' => 255, 'a' => 0]);
        //$qrCode->setLabel('Scan the code', 16, __DIR__ . '/../assets/fonts/noto_sans.otf', LabelAlignment::CENTER);
        //$qrCode->setLogoPath(__DIR__ . '/../assets/images/symfony.png');
        //$qrCode->setLogoSize(150, 200);
        $qrCode->setRoundBlockSize(true);
        $qrCode->setValidateResult(true);
        $qrCode->setWriterOptions(['exclude_xml_declaration' => true]);
        $qrFilePath = $this->getReportPath() . '/remito-qrcode.png';
        $qrCode->writeFile($qrFilePath);

        return $qrFilePath;
    }

    public function detalle(Request $request) {
        $parentId = $request->input('parent_id');
        DB::statement(DB::raw('set @rownum=0'));
        $detalle = RemitoLinea::with('articulo', 'presentacion')->select([DB::raw('@rownum  := @rownum  + 1 AS rownum'),'remito_linea.*'])
                                                    ->where('remito_id', '=', $parentId);
        return Datatables::of($detalle)
                ->addColumn('action', function ($linea) {
                        $nombre = htmlspecialchars($linea->articulo->nombre);
                        return
                            '<span class="btn btn-sm">'.
                                '<input type="checkbox" name="row_select" data-id="'.$linea->id.'" title="Selecciona fila" onclick="onRowSelect(this)"/>'.
                            '</span>'.
                            '<a class="btn btn-sm btn-primary" title="Editar" style="text-decoration: none;" href="#modalForm"'.
                            '  data-toggle="modal" data-href="'.url('remito-linea/update/'.$linea->id).'">'.
                                '<i class="voyager-edit"></i>'.
                            '</a>'.
                            '<input type="hidden" name="_method" value="delete"/>'.
                            '<a class="btn btn-danger btn-sm" title="Eliminar" style="text-decoration: none;"'.
                            '  data-toggle="modal" href="#modalDelete"'.
                            '  data-id="'.$linea->id.'"'.
                            '  data-token="'.csrf_token().'"'.
                            '  data-nrolinea="'.$linea->rownum.'"'.
                            '  data-nombre="'.$nombre.'"'.
                            '>'.
                                '<i class="voyager-trash"></i>'.
                            '</a>'
                            ;
                    })
                ->orderColumn('articulo.nombre', 'articulo.nombre $1')
                ->make(true);
    }

    protected function getValidationRules(Request $request, $parentId) {
        $remito_id = $parentId;
        $articulo_id = $request->articulo_id;
        return [
            'articulo_id' => [
                'required',
//                Rule::unique('remito_linea')->where(function ($query) use($remito_id, $articulo_id) {
//                    return $query->where('remito_id', $remito_id)->where('articulo_id', $articulo_id);
//                }),
            ],
            'cantidad' => 'required|integer|gt:0',
        ];
    }

    protected function getAttributeNames() {
        return [
            'articulo_id' => 'Artículo',
            'cantidad' => 'Cantidad',
        ];
    }

    protected function getParentId(Request $request) {
        return $request->remito_id;
    }

    protected function createEntidad(Request $request, $parentId) {
        $linea = new RemitoLinea();
        $linea->remito_id = $parentId;
        $linea->articulo_id = $request->articulo_id;
        $linea->cantidad = $request->cantidad;
        $linea->presentacion_id = $request->presentacion_id;
        $linea->save();
        $this->updateParentInfo($parentId);
    }

    protected function saveEntidad(Request $request, $linea) {
        $linea->articulo_id = $request->articulo_id;
        $linea->cantidad = $request->cantidad;
        $linea->presentacion_id = $request->presentacion_id;
        $linea->save();
        $this->updateParentInfo($linea->remito_id);
    }

    public function deleteLinea($id) {
        $linea = $this->getLinea($id);
        $linea->delete();
        $this->updateParentInfo($linea->remito_id);
        return response()->json([
            'fail' => false,
            'table_refresh' => 'detalle-table'
        ]);
    }

    // Genera un remito de salida con algunas o todas las lineas del
    // remito provisorio actual
    public function definitivo(Request $request, $remitoId, $ids) {
        // Consulta el remito
        $remito = Remito::find($remitoId);
        // Le setea los campos de tipo y transportista
        $remito->tipo = 'REMITO_SALIDA';
        $remito->numero = $this->generarNumeroRemito($remito->tipo, $remito->deposito_id);
        $remito->transportador = $request->input('transportador');
        $remito->patente = $request->input('patente');
        $remito->conductor = $request->input('conductor');
        $remito->dni = $request->input('dni');
        $remito->telefono = $request->input('telefono');
        $remito->precintos = $request->input('precintos');
        if($ids == 'ALL') // Convierte el remito provisorio en definitivo
            $remito->save();
        else { // Crea un remito definitivo con las lineas seleccionadas
            $remito->insertNew(); // Le borra el id e inserta un registro nuevo
            // mueve las lineas
            foreach(explode(',', $ids) as $id) {
                $linea = $this->getLinea($id);
                $linea->remito_id = $remito->id;
                $linea->save();
            }
            $this->updateParentInfo($remito->id);
        }
        $this->updateParentInfo($remitoId);
        return response()->json([
            'fail' => false,
            'table_refresh' => 'detalle-table',

            'modifico' => $ids == 'ALL',
            'tipo' => $remito->tipo,
            'numero' => $remito->numero
        ]);
    }

    // Función que se invoca desde la vista por ajax al cambiar el artículo
    public function getPresentaciones(Request $request) {
        $remitoLineaId = $request->input('remitoLineaId');
        $articuloId = $request->input('articuloId');
        $selectValues = [];
        $defaultValue = null;
        foreach (Presentacion::where('articulo_id', '=', $articuloId)->whereNull('deleted_at')->orderBy('nombre', 'ASC')->get() as $item) {
            if($item->por_defecto)
                $defaultValue = $item->id;
            array_push($selectValues, [
                'id' => $item->id,
                'nombre' => $item->nombre
            ]);
        }
        return response()->json([
            'defaultValue'  => $defaultValue,
            'selectedValue' => $remitoLineaId != null ? $this->getLinea($remitoLineaId)->presentacion_id : null,
            'selectValues'  => $selectValues
        ]);        
    }

    private function updateParentInfo($remitoId) {
        // Hay que actualizar remito.peso y remito.volumen determinado por la presentación del artículo
        $remito = Remito::find($remitoId);
        if($remito->tipo === 'REMITO_SALIDA' || $remito->tipo === 'PROVISORIO_SALIDA') {
            $peso = 0;
            $volumen = 0;
            $bultos = 0;
            foreach (RemitoLinea::with('presentacion')->where('remito_id', '=', $remitoId)->get() as $item) {
                if($item->presentacion != null) {
                    $b = $item->presentacion->cantidad != null ? ceil($item->cantidad / $item->presentacion->cantidad) : 1;
                    if($item->presentacion->peso != null)
                        $peso = $peso + $b * $item->presentacion->peso;
                    if($item->presentacion->volumen != null)
                        $volumen = $volumen + $b * $item->presentacion->volumen;
                    $bultos = $bultos + $b;
                } else
                    $bultos++;
            }
            $remito->cantidad_bultos = $bultos;
            $remito->peso = $peso;
            $remito->volumen = $volumen;
            $remito->save();
        }
    }

    // Función que se invoca desde la vista por ajax al darle submit a la popup del detalle para actualizar campos
    public function getSalidaInfo(Request $request) {
        $remitoId = $request->input('remitoId');
        $remito = Remito::find($remitoId);
        return response()->json([
            'bultos' => $remito->cantidad_bultos,
            'peso' => $remito->peso,
            'volumen' => $remito->volumen
        ]);        
    }

    protected function getLinea($id) {
        return RemitoLinea::find($id);
    }
}
