<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class RemitoLinea extends Model
{
    protected $table = 'remito_linea';
   
    public function articuloId()
    {
        return $this->belongsTo('App\Almacenes\Model\Articulo');
    }
    public function articulo()
    {
        return $this->belongsTo('App\Almacenes\Model\Articulo');
    }

}
