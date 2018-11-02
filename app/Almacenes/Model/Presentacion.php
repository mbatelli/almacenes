<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Presentacion extends Model
{
    protected $table = 'presentacion';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function articuloId()
    {
        return $this->belongsTo('App\Almacenes\Model\Articulo');
    }

    protected function listDropDown()
    {
        return Presentacion::orderBy('nombre', 'asc')->get();
    }
}
