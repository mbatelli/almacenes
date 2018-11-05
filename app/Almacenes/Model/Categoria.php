<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Categoria extends Model
{
    use SoftDeletes;

    protected $table = 'categoria';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected function listDropDown()
    {
        return Categoria::orderBy('nombre', 'asc')->get();
    }
}
