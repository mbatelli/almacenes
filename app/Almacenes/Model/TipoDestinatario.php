<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class TipoDestinatario extends Model
{
    use SoftDeletes;

    protected $table = 'tipo_destinatario';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected function listDropDown()
    {
        return TipoDestinatario::orderBy('nombre', 'asc')->get();
    }
}
