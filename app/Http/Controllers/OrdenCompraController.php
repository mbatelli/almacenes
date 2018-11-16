<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Yajra\DataTables\DataTables;
use App\Almacenes\Model\OrdenCompraLinea;

class OrdenCompraController extends EntidadConDetalleController
{
    public function detalle(Request $request)
    {
        $parentId = $request->input('parent_id');
        DB::statement(DB::raw('set @rownum=0'));
        $detalle = OrdenCompraLinea::with('articulo')->select([DB::raw('@rownum  := @rownum  + 1 AS rownum'),'orden_compra_linea.*'])
                                                    ->where('orden_compra_id', '=', $parentId);
        return Datatables::of($detalle)
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

    protected function getValidationRules() {
        return [
            'articulo_id' => 'required',
            'cantidad' => 'required|integer|gt:0',
            'precio' => 'required|numeric|gte:0',
        ];
    }

    protected function getAttributeNames() {
        return [
            'articulo_id' => 'Artículo',
            'cantidad' => 'Cantidad',
            'precio' => 'Precio',
        ];
    }

    protected function createEntidad(Request $request, $parentId) {
        $linea = new OrdenCompraLinea();
        $linea->orden_compra_id = $parentId;
        $linea->articulo_id = $request->articulo_id;
        $linea->precio = $request->precio;
        $linea->cantidad = $request->cantidad;
        $linea->save();
    }

    protected function saveEntidad(Request $request, $linea) {
        $linea->articulo_id = $request->articulo_id;
        $linea->precio = $request->precio;
        $linea->cantidad = $request->cantidad;
        $linea->save();
    }

    protected function getLinea($id) {
        return OrdenCompraLinea::find($id);
    }
}
