<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class OrdenCompra extends Model
{
    protected $table = 'orden_compra';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function proveedorId()
    {
        return $this->belongsTo('App\Almacenes\Model\Proveedor');
    }

    public function detalle()
    {
        return $this->hasMany('App\Almacenes\Model\OrdenCompraLinea');
    }
}
