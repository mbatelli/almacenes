<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class TipoDestinatario extends Model
{
    protected $table = 'tipo_destinatario';

    protected function listDropDown()
    {
        return TipoDestinatario::orderBy('nombre', 'asc')->get();
    }
}
