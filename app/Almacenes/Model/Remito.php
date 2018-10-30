<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Remito extends Model
{
    protected $table = 'remito';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function depositoId()
    {
        return $this->belongsTo('App\Almacenes\Model\Deposito');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function destinatarioId()
    {
        return $this->belongsTo('App\Almacenes\Model\Destinatario');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function procesoElectoralId()
    {
        return $this->belongsTo('App\Almacenes\Model\ProcesoElectoral');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function proveedorId()
    {
        return $this->belongsTo('App\Almacenes\Model\Proveedor');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function ordenCompraId()
    {
        return $this->belongsTo('App\Almacenes\Model\OrdenCompra');
    }
}
