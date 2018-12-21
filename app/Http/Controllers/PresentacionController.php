<?php

namespace App\Http\Controllers;

use Illuminate\Validation\Rule;
use App\Http\Controllers\Voyager\VoyagerBaseController;
use Validator;

class PresentacionController extends VoyagerBaseController
{
    public function validateBread($request, $data, $name = null, $id = null)
    {
        $rules = [];
        $messages = [
            'nombre.unique' => 'El valor del campo Nombre ya está en uso para el Artículo seleccionado.'
        ];
        $customAttributes = [
            'nombre' => 'Nombre',
            'articulo_id' => 'Artículo',
            'cantidad' => 'Cantidad',
            'peso' => 'Peso',
            'volumen' => 'Volumen',
        ];
        $is_update = $name && $id;
        $nombre = $request['nombre'];
        $articulo_id = $request['articulo_id'];
        $uniqueNombre = null;
        
        if($is_update)
            $uniqueNombre = Rule::unique('presentacion')->where(function ($query) use($articulo_id, $nombre) {
                return $query->where('articulo_id', $articulo_id)->where('nombre', $nombre);
            })->ignore($id);
        else
            $uniqueNombre = Rule::unique('presentacion')->where(function ($query) use($articulo_id, $nombre) {
                return $query->where('articulo_id', $articulo_id)->where('nombre', $nombre);
            });

        $rules = [
            'nombre' => [
                'required',
                'max:100',
                $uniqueNombre,
            ],
            'articulo_id' => [
                'required',
            ],
            'cantidad' => 'required|integer|gt:0',
            'peso' => 'required|numeric|gt:0',
            'volumen' => 'required|numeric|gt:0',
        ];
        
        return Validator::make($request, $rules, $messages, $customAttributes);
    }    
}
