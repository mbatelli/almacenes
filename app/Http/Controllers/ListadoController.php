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
        $columns = array(new ColumnDef('articulo', 'Articulo'), new ColumnDef('stock_critico', 'Stock Crítico'));

        $collection = Articulo::all();
        $data = [];
        foreach ($collection as $item) {
            $rowData = new RowData();

            $rowData->values = array(
                'articulo' => $item->nombre,
                'stock_critico' => $item->stock_critico
            );

            array_push($data, $rowData);
        }

        $queryDef = new QueryDef('voyager-download', 'Listado de Valorizacion', $columns, $data);
        $isServerSide = false;
        $view = "listado";
        return view('listado', compact('queryDef', 'isServerSide'));
    }
}
