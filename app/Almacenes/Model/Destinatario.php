<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Destinatario extends Model
{
    use SoftDeletes;

    protected $table = 'destinatario';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

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
        return $this->belongsTo('App\Almacenes\Model\Ciudad','ciudad_id');
    }
}
