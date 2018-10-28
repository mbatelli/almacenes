<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Events\BreadDataDeleted;
use TCG\Voyager\Events\BreadDataUpdated;
use TCG\Voyager\Events\BreadImagesDeleted;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Controllers\Traits\BreadRelationshipParser;
use App\Http\Controllers\Voyager\VoyagerBaseController;
use App\DataTables\OrdenCompraLineasDataTable;
use Yajra\DataTables\DataTables;
use App\Almacenes\Model\OrdenCompraLinea;
use App\Almacenes\Model\OrdenCompra;
use App\Almacenes\Model\Articulo;

class OrdenCompraController extends VoyagerBaseController
{
    public function getSlug(Request $request)
    {
        return 'orden-compra';
    }

    public function edit(Request $request, $id)
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

        $view = 'voyager::bread.edit-add';

        if (view()->exists("voyager::$slug.edit-add")) {
            $view = "voyager::$slug.edit-add";
        }

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
    }

    public function create(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('add', app($dataType->model_name));

        $dataTypeContent = (strlen($dataType->model_name) != 0)
                            ? new $dataType->model_name()
                            : false;

        foreach ($dataType->addRows as $key => $row) {
            $details = json_decode($row->details);
            $dataType->addRows[$key]['col_width'] = isset($details->width) ? $details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'add');

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'voyager::bread.edit-add';

        if (view()->exists("voyager::$slug.edit-add")) {
            $view = "voyager::$slug.edit-add";
        }

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
    }

    public function ordenCompraLinea(Request $request, DataTables $dataTables)
    {
        $ordenCompraId = $request->input('orden_compra_id');
        $lineas = OrdenCompraLinea::with('articulo')->select('orden_compra_linea.*')->where('orden_compra_id', '=', $ordenCompraId);

        return Datatables::of($lineas)
                    ->addColumn('action', function ($linea) {
                        return
                            '<a class="btn btn-sm btn-primary" title="Editar" style="text-decoration: none;" href="#modalForm" data-toggle="modal" data-href="'.url('orden-compra-linea/update/'.$linea->id).'">'.
                            '<i class="voyager-edit"></i>'.
                            '</a>'.
                            '<input type="hidden" name="_method" value="delete"/>'.
                            '<a class="btn btn-danger btn-sm" title="Eliminar" style="text-decoration: none;" data-toggle="modal" href="#modalDelete"'.
                            '  data-id="'.$linea->id.'"'.
                            '  data-token="'.csrf_token().'">'.
                            '<i class="voyager-trash"></i>'.
                            '</a>'
                            ;
                    })
                    ->make(true);
    }

    public function editOrdenCompraLinea(Request $request, $id)
    {
        $slug = 'orden-compra-linea';//$this->getSlug($request);

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
            $ordenCompraLinea->precio = $request->precio;
            $ordenCompraLinea->cantidad = $request->cantidad;
            $ordenCompraLinea->save();
            return response()->json([
                'fail' => false,
                'redirect_url' => url('orden-compra/'.$ordenCompraLinea->ordenCompraId.'/edit')
            ]);
        }
    }

    public function ordenCompraLineaDelete($id)
    {
        $ordenCompraLinea = OrdenCompraLinea::with('ordenCompra')->find($id);
        $ordenCompra = $ordenCompraLinea->ordenCompra;
        //$ordenCompraLinea->delete();

        return redirect()
            ->route('orden-compra.edit', $ordenCompra->id)
            ->with([
                'message'    => __('voyager::generic.successfully_deleted')." Línea de Orden de Compra",
                'alert-type' => 'success',
            ]);
    }
}
