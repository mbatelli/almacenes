<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Categoria extends Model
{
    protected $table = 'categoria';

    protected function listDropDown()
    {
        return Categoria::orderBy('nombre', 'asc')->get();
    }
}
