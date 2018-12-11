<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Almacenes\Model\Articulo;
use App\Almacenes\ColumnDef;
use App\Almacenes\QueryDef;
use App\Almacenes\RowData;

class ListadoController extends Controller
{
    public function consultaExistencia(Request $request) {
        $columns = array(new ColumnDef('deposito', 'Deposito'), new ColumnDef('codigo', 'Cod'), 
                        new ColumnDef('articulo', 'Articulo'), new ColumnDef('stock', 'Stock'));

        $collection = DB::table('articulo')
                        ->join('remito_linea', 'articulo.id' , '=', 'remito_linea.articulo_id')
                        ->join('remito', 'remito.id' , '=', 'remito_linea.remito_id')
                        ->join('deposito', 'deposito.id' , '=', 'remito.deposito_id')
                        ->select('deposito.nombre as deposito', 'articulo.codigo as codigo', 
                                'articulo.nombre as articulo', DB::raw('sum(IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,-remito_linea.cantidad)) as stock'))
                        ->where('remito.tipo','<>','PROVISORIO_SALIDA')
                        ->groupBy('deposito.id','articulo.id')
                        ->get();
        $data = [];
        foreach ($collection as $item) {
            $rowData = new RowData();

            $rowData->values = array(
                'deposito' => $item->deposito,
                'codigo' => $item->codigo,
                'articulo' => $item->articulo,
                'stock' => $item->stock
            );

            array_push($data, $rowData);
        }

        $queryDef = new QueryDef('voyager-download', 'Consulta de Existencias', $columns, $data);
        $isServerSide = false;
        return view('listado', compact('queryDef', 'isServerSide'));
    }

    public function puntosStockCriticos(Request $request) {
        $columns = array(new ColumnDef('deposito', 'Deposito'), new ColumnDef('codigo', 'Cod'), 
                        new ColumnDef('articulo', 'Articulo'), new ColumnDef('stockCritico', 'Stock Critico'), new ColumnDef('stock', 'Stock'));

        $collection = DB::table('articulo')
                        ->join('remito_linea', 'articulo.id' , '=', 'remito_linea.articulo_id')
                        ->join('remito', 'remito.id' , '=', 'remito_linea.remito_id')
                        ->join('deposito', 'deposito.id' , '=', 'remito.deposito_id')
                        ->select('deposito.nombre as deposito', 'articulo.codigo as codigo', 
                                'articulo.nombre as articulo', 'articulo.stock_critico as critico', DB::raw('sum(IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,-remito_linea.cantidad)) as stock'))
                        ->where('remito.tipo','<>','PROVISORIO_SALIDA')
                        ->groupBy('deposito.id','articulo.id')
                        ->havingRaw('sum(IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,-remito_linea.cantidad)) < articulo.stock_critico')
                        ->get();
        $data = [];
        foreach ($collection as $item) {
            $rowData = new RowData();

            $rowData->values = array(
                'deposito' => $item->deposito,
                'codigo' => $item->codigo,
                'articulo' => $item->articulo,
                'stockCritico' => $item->critico,
                'stock' => $item->stock
            );

            array_push($data, $rowData);
        }

        $queryDef = new QueryDef('voyager-download', 'Puntos de Stock Criticos', $columns, $data);
        $isServerSide = false;
        return view('listado', compact('queryDef', 'isServerSide'));
    }

    public function listadoValorizacion(Request $request) {
        $fechaDeHoy = new \DateTime();
        $columns = array(new ColumnDef('deposito', 'Deposito'), new ColumnDef('codigo', 'Cod'), 
                        new ColumnDef('articulo', 'Articulo'), 
                        new ColumnDef('stock', 'Stock al '.$fechaDeHoy->format('d/m/Y')),
                        new ColumnDef('nrosOC', 'Nro. OC'), new ColumnDef('fechasOC', 'Fecha'),
                        new ColumnDef('preciosOC', 'Precio'), new ColumnDef('costo', 'Costo'),
                        new ColumnDef('total', 'Total'));

        $collection = DB::table('articulo')
                        ->join('remito_linea', 'articulo.id' , '=', 'remito_linea.articulo_id')
                        ->join('remito', 'remito.id' , '=', 'remito_linea.remito_id')
                        ->join('deposito', 'deposito.id' , '=', 'remito.deposito_id')
                        ->leftJoin('orden_compra', 'orden_compra.id' , '=', 'remito.orden_compra_id')
                        ->leftJoin('orden_compra_linea', 
                            function($join){$join->on('orden_compra.id' , '=', 'orden_compra_linea.orden_compra_id');
                                 $join->on('articulo.id' , '=', 'orden_compra_linea.articulo_id');})
                        ->select('deposito.nombre as deposito', 'articulo.codigo as codigo', 'articulo.nombre as articulo', 
                                DB::raw('sum(IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,-remito_linea.cantidad)) as stock'),
                                DB::raw('FORMAT(sum(IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,0)*IF(remito.tipo="REMITO_ENTRADA",orden_compra_linea.precio,0)) / sum(IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,-remito_linea.cantidad)),2,"es_AR") as costo'),
                                DB::raw('FORMAT(sum(IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,0)*IF(remito.tipo="REMITO_ENTRADA",orden_compra_linea.precio,0)),2,"es_AR") as total'),
                                DB::raw('GROUP_CONCAT(orden_compra.nro_orden_compra SEPARATOR "|") as nrosOC'),
                                DB::raw('GROUP_CONCAT(DATE_FORMAT(orden_compra.fecha, "%d/%m/%Y") SEPARATOR "|") as fechasOC'),
                                DB::raw('GROUP_CONCAT(FORMAT(orden_compra_linea.precio,2,"es_AR") SEPARATOR "|") as preciosOC'))
                        ->where('remito.tipo','<>','PROVISORIO_SALIDA')
                        ->groupBy('deposito.id','articulo.id')
                        ->get();
        $data = [];
        foreach ($collection as $item) {
            $rowData = new RowData();

            $rowData->values = array(
                'deposito' => $item->deposito,
                'codigo' => $item->codigo,
                'articulo' => $item->articulo,
                'stock' => $item->stock,
                'nrosOC' => $item->nrosOC,
                'fechasOC' => $item->fechasOC,
                'preciosOC' => $item->preciosOC,
                'costo' => $item->costo,
                'total' => $item->total
            );

            array_push($data, $rowData);
        }

        $queryDef = new QueryDef('voyager-download', 'Listado de Valorizacion', $columns, $data);
        $isServerSide = false;
        return view('listado', compact('queryDef', 'isServerSide'));
    }

    public function listadoHistorial(Request $request) {
        $fechaDeHoy = new \DateTime();
        $columns = array(new ColumnDef('remito', 'Remito'), 
                        new ColumnDef('fecha', 'Fecha'), 
                        new ColumnDef('ordenCompra', 'Orden de Compra'),
                        new ColumnDef('descripcion', 'Descripcion'), 
                        new ColumnDef('ingreso', 'Ingreso'), new ColumnDef('egreso', 'Egreso'),
                        new ColumnDef('saldo', 'Saldo'));
        DB::statement(DB::raw('set @total:=0'));
        $collection = DB::table('remito_linea')
                        ->join('remito', 'remito.id' , '=', 'remito_linea.remito_id')
                        ->leftJoin('orden_compra', 'orden_compra.id' , '=', 'remito.orden_compra_id')
                        ->leftJoin('destinatario', 'destinatario.id' , '=', 'remito.destinatario_id')
                        ->select(DB::raw('CONCAT(LPAD(remito.punto_venta, 4, "0"),"-",LPAD(remito.numero, 8, "0")) as remito'),
                                DB::raw('DATE_FORMAT(remito.fecha, "%d/%m/%Y") as fecha'), 
                                'orden_compra.nro_orden_compra as ordenCompra', 
                                'destinatario.nombre as descripcion', 
                                DB::raw('IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,"") as ingreso'),
                                DB::raw('IF(remito.tipo="REMITO_SALIDA",remito_linea.cantidad,"") as egreso'),
                                DB::raw('@total:=@total+IF(remito.tipo="REMITO_ENTRADA",remito_linea.cantidad,-remito_linea.cantidad) as saldo'))
                        ->where('remito.tipo','<>','PROVISORIO_SALIDA')
                        ->get();
        $data = [];
        foreach ($collection as $item) {
            $rowData = new RowData();

            $rowData->values = array(
                'remito' => $item->remito,
                'fecha' => $item->fecha,
                'ordenCompra' => $item->ordenCompra,
                'descripcion' => $item->descripcion,
                'ingreso' => $item->ingreso,
                'egreso' => $item->egreso,
                'saldo' => $item->saldo
            );

            array_push($data, $rowData);
        }

        $queryDef = new QueryDef('voyager-download', 'Historial De Movimientos', $columns, $data);
        $isServerSide = false;
        return view('listado', compact('queryDef', 'isServerSide'));
    }
}
