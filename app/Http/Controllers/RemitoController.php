<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Events\BreadDataDeleted;
use TCG\Voyager\Events\BreadDataUpdated;
use TCG\Voyager\Events\BreadImagesDeleted;
use TCG\Voyager\Facades\Voyager as VoyagerFacade;
use TCG\Voyager\Http\Controllers\Traits\BreadRelationshipParser;
use App\Http\Controllers\Voyager\VoyagerBaseController;
use Yajra\DataTables\DataTables;
use App\Almacenes\Model\RemitoLinea;
use App\Almacenes\Model\Remito;
use App\Almacenes\Model\Deposito;
use App\Almacenes\Model\Ciudad;
use App\Almacenes\Model\Articulo;
use App\Almacenes\Actions\PrintAction;
use Endroid\QrCode\ErrorCorrectionLevel;
use Endroid\QrCode\LabelAlignment;
use Endroid\QrCode\QrCode;
use Endroid\QrCode\Response\QrCodeResponse;

class RemitoController extends VoyagerBaseController
{
    public function getSlug(Request $request)
    {
        $slug = parent::getSlug($request);
        if($slug == null)
            $slug = explode('/', $request->route()->uri)[0];
        return $slug;
    }

    public function specifyActions() {
        parent::specifyActions();
        VoyagerFacade::addAction(PrintAction::class);
    }

    public function print(Request $request, $id) {
        $remito = Remito::with('depositoId','depositoId.ciudadId','destinatarioId','destinatarioId.ciudadId','detalle','detalle.articulo')->findOrFail($id);
        $detalle = [];
        foreach ($remito->detalle->all() as $item) {
            array_push($detalle, [
                'articulo' => $item->articulo->nombre,
                'cantidad' => $item->cantidad
            ]);
        }        
        $data = [
            'remito' => [
                'numero' => str_pad($remito->depositoId->punto_venta, 3, '0', STR_PAD_LEFT)."-".str_pad($remito->numero, 3, '0', STR_PAD_LEFT),
                'fecha' => \DateTime::createFromFormat('Y-m-d', $remito->fecha),
                'depositoDireccion' => $remito->depositoId->direccion." ".$remito->depositoId->ciudadId->nombre,
                'depositoTelefono' => $remito->depositoId->telefono,
                'destinatario' => $remito->destinatarioId->nombre,
                'destinatarioDireccion' => $remito->destinatarioId->direccion." ".$remito->destinatarioId->ciudadId->nombre,
                'detalle' => $detalle
            ]
        ];
        $jsondata = json_encode($data, JSON_PRETTY_PRINT);
        $data_file = $this->getReportPath() . '/remito.json';
        file_put_contents($data_file, $jsondata);
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

    /*
    $params = [
        'numero' => 123456,
        'qr' => $this->generateQR($remito)
    ];
    */
    private function generateQR($remito) {
        // Create a basic QR code
        $qrCode = new QrCode('123456');
        $qrCode->setSize(300);

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

/*
    public function ordenCompraLinea(Request $request, DataTables $dataTables)
    {
        $ordenCompraId = $request->input('orden_compra_id');
        DB::statement(DB::raw('set @rownum=0'));
        $lineas = OrdenCompraLinea::with('articulo')->select([DB::raw('@rownum  := @rownum  + 1 AS rownum'),'orden_compra_linea.*'])
                                                    ->where('orden_compra_id', '=', $ordenCompraId);
        return Datatables::of($lineas)
                ->addColumn('action', function ($linea) {
                        $nombre = htmlspecialchars($linea->articulo->nombre);
                        return
                            '<a class="btn btn-sm btn-primary" title="Editar" style="text-decoration: none;" href="#modalForm"'.
                            '  data-toggle="modal" data-href="'.url('orden-compra-linea/update/'.$linea->id).'">'.
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

    public function createOrdenCompraLinea(Request $request, $idOrden)
    {
        if ($request->isMethod('get')) {
            $slug = $this->getSlug($request);

            $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

            $relationships = $this->getRelationships($dataType);

            // Check permission
            $this->authorize('add', app($dataType->model_name));

            $dataTypeContent = (strlen($dataType->model_name) != 0)
                                ? new $dataType->model_name()
                                : false;

            foreach ($dataType->editRows as $key => $row) {
                $details = json_decode($row->details);
                $dataType->editRows[$key]['col_width'] = isset($details->width) ? $details->width : 100;
            }

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'add');

            // Check if BREAD is Translatable
            $isModelTranslatable = is_bread_translatable($dataTypeContent);

            $view = 'voyager::orden-compra.orden-compra-linea-form';

            return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
        } else { // POST
            $rules = [
                'cantidad' => 'required',
                //'email' => 'required|email',
            ];
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails())
                return response()->json([
                    'fail' => true,
                    'errors' => $validator->errors()
                ]);
            $ordenCompraLinea = new OrdenCompraLinea();
            $ordenCompraLinea->orden_compra_id = $idOrden;
            $ordenCompraLinea->articulo_id = $request->articulo_id;
            $ordenCompraLinea->precio = $request->precio;
            $ordenCompraLinea->cantidad = $request->cantidad;
            $ordenCompraLinea->save();
            return response()->json([
                'fail' => false,
                'table_refresh' => 'orden-compra-lineas-table'
            ]);
        }
    }

    public function editOrdenCompraLinea(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $relationships = $this->getRelationships($dataType);

        $dataTypeContent = (strlen($dataType->model_name) != 0)
                ? app($dataType->model_name)->with($relationships)->findOrFail($id)
                : DB::table($dataType->name)->where('id', $id)->first(); // If Model doest exist, get data from table name

        foreach ($dataType->editRows as $key => $row) {
            $details = json_decode($row->details);
            $dataType->editRows[$key]['col_width'] = isset($details->width) ? $details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'edit');

        // Check permission
        $this->authorize('edit', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'voyager::orden-compra.orden-compra-linea-form';

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
    }

    public function ordenCompraLineaUpdate(Request $request, $id)
    {
        if ($request->isMethod('get'))
            return $this->editOrdenCompraLinea($request, $id);
        else {
            $rules = [
                'cantidad' => 'required',
                //'email' => 'required|email',
            ];
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails())
                return response()->json([
                    'fail' => true,
                    'errors' => $validator->errors()
                ]);
            $ordenCompraLinea = OrdenCompraLinea::find($id);
            $ordenCompraLinea->articulo_id = $request->articulo_id;
            $ordenCompraLinea->precio = $request->precio;
            $ordenCompraLinea->cantidad = $request->cantidad;
            $ordenCompraLinea->save();
            return response()->json([
                'fail' => false,
                'table_refresh' => 'orden-compra-lineas-table'
            ]);
        }
    }

    public function ordenCompraLineaDelete($id)
    {
        $ordenCompraLinea = OrdenCompraLinea::with('ordenCompra')->find($id);
        $ordenCompra = $ordenCompraLinea->ordenCompra;
        $ordenCompraLinea->delete();
        return response()->json([
            'fail' => false,
            'table_refresh' => 'orden-compra-lineas-table'
        ]);
    }
    */
}
