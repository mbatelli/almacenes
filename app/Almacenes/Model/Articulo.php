<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Articulo extends Model
{
    protected $table = 'articulo';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function categoriaId()
    {
        return $this->belongsTo('App\Almacenes\Model\Categoria');
    }
}
