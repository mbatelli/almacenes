<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Provincia extends Model
{
    protected $table = 'provincia';

    protected function listDropDown()
    {
        return Provincia::orderBy('nombre', 'asc')->get();
    }
}
