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

        $queryDef = new QueryDef('voyager-download', 'Consulta de Existencias', $columns, $data);
        $isServerSide = false;
        $view = "listado";
        return view('listado', compact('queryDef', 'isServerSide'));
    }

    public function puntosStockCriticos(Request $request) {
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

        $queryDef = new QueryDef('voyager-download', 'Consulta de Existencias', $columns, $data);
        $isServerSide = false;
        $view = "listado";
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

        $queryDef = new QueryDef('voyager-download', 'Consulta de Existencias', $columns, $data);
        $isServerSide = false;
        $view = "listado";
        return view('listado', compact('queryDef', 'isServerSide'));
    }
}
