<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class ProcesoElectoral extends Model
{
    protected $table = 'proceso_electoral';

    protected function listDropDown()
    {
        return ProcesoElectoral::orderBy('nombre', 'asc')->get();
    }
}
