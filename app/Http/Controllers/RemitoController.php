<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use TCG\Voyager\Facades\Voyager;
use Yajra\DataTables\DataTables;
use App\Almacenes\Model\RemitoLinea;
use App\Almacenes\Actions\PrintAction;
use Endroid\QrCode\ErrorCorrectionLevel;
use Endroid\QrCode\LabelAlignment;
use Endroid\QrCode\QrCode;
use App\Almacenes\Model\Deposito;
use Illuminate\Support\Carbon;

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
        $deposito = Deposito::findOrFail($depositoId);
        return [
            'puntoVenta' => $deposito->punto_venta,
            'numero' => 111111
        ];
    }

    // Función que se invoca desde la vista por ajax al cambiar el tipo o deposito
    public function getNumero(Request $request) {
        $depositoId = $request->input('depositoId');
        $tipoRemito = $request->input('tipoRemito');
        $numero = $this->generarNumeroRemito($tipoRemito, $depositoId);
        return response()->json([
            'puntoVenta' => $numero['puntoVenta'],
            'numero' => $numero['numero']
        ]);
    }

    // Función para inicializar la entidad (Remito)
    protected function initContent($dataTypeContent) {
        $dataTypeContent->tipo = config('app.almacenes.remito_por_defecto');
        $dataTypeContent->deposito_id = $this->getDepositoPorPuntoVenta(config('app.almacenes.punto_venta_por_defecto'))->id;
        $numero = $this->generarNumeroRemito($dataTypeContent->tipo, $dataTypeContent->deposito_id);
        $dataTypeContent->punto_venta = $numero['puntoVenta'];
        $dataTypeContent->numero = $numero['numero'];
        $dataTypeContent->fecha = Carbon::now();
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

    public function detalle(Request $request)
    {
        $parentId = $request->input('parent_id');
        DB::statement(DB::raw('set @rownum=0'));
        $detalle = RemitoLinea::with('articulo')->select([DB::raw('@rownum  := @rownum  + 1 AS rownum'),'remito_linea.*'])
                                                    ->where('remito_id', '=', $parentId);
        return Datatables::of($detalle)
                ->addColumn('action', function ($linea) {
                        $nombre = htmlspecialchars($linea->articulo->nombre);
                        return
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

    protected function getValidationRules() {
        return [
            'articulo_id' => 'required',
            'cantidad' => 'required|integer|gt:0',
        ];
    }

    protected function getAttributeNames() {
        return [
            'articulo_id' => 'Artículo',
            'cantidad' => 'Cantidad',
        ];
    }

    protected function createEntidad(Request $request, $parentId) {
        $linea = new RemitoLinea();
        $linea->remito_id = $parentId;
        $linea->articulo_id = $request->articulo_id;
        $linea->cantidad = $request->cantidad;
        $linea->save();
    }

    protected function saveEntidad(Request $request, $linea) {
        $linea->articulo_id = $request->articulo_id;
        $linea->cantidad = $request->cantidad;
        $linea->save();
    }

    protected function getLinea($id) {
        return RemitoLinea::find($id);
    }
}
