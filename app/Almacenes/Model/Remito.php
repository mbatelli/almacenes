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
        return $this->belongsTo('App\Almacenes\Model\Deposito','deposito_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function destinatarioId()
    {
        return $this->belongsTo('App\Almacenes\Model\Destinatario','destinatario_id');
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

    public function detalle()
    {
        return $this->hasMany('App\Almacenes\Model\RemitoLinea');
    }

    public function showPrintAction() {
        return 'REMITO_ENTRADA' != $this->tipo;
    }

    // Lo convierte en un nuevo remito y lo inserta
    public function insertNew()
    {
        $this->id = null;
        $this->exists = false;
        $this->save();
    }
}
