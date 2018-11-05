<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Presentacion extends Model
{
    use SoftDeletes;

    protected $table = 'presentacion';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected function listDropDown()
    {
        return Presentacion::orderBy('nombre', 'asc')->get();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function articuloId()
    {
        return $this->belongsTo('App\Almacenes\Model\Articulo');
    }
}
