<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Destinatario extends Model
{
    protected $table = 'destinatario';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function tipoDestinatarioId()
    {
        return $this->belongsTo('App\Almacenes\Model\TipoDestinatario');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function ciudadId()
    {
        return $this->belongsTo('App\Almacenes\Model\Ciudad');
    }
}
