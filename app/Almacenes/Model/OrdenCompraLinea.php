<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class OrdenCompraLinea extends Model
{
    protected $table = 'orden_compra_linea';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function ordenCompraId()
    {
        return $this->belongsTo('App\Almacenes\Model\OrdenCompra');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function articuloId()
    {
        return $this->belongsTo('App\Almacenes\Model\Articulo');
    }
}
