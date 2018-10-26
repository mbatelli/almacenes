<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class OrdenCompraLinea extends Model
{
    protected $table = 'orden_compra_linea';
    protected $appends = ['precio_formateado'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function ordenCompra()
    {
        return $this->belongsTo('App\Almacenes\Model\OrdenCompra', 'orden_compra_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function articulo()
    {
        return $this->belongsTo('App\Almacenes\Model\Articulo', 'articulo_id', 'id');
    }

    public function getPrecioFormateadoAttribute()
    {
        return number_format($this->attributes['precio'], 2, ',', '.');
    }

}
