<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class ProcesoElectoral extends Model
{
    use SoftDeletes;

    protected $table = 'proceso_electoral';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected function listDropDown()
    {
        return ProcesoElectoral::orderBy('nombre', 'asc')->get();
    }
}
