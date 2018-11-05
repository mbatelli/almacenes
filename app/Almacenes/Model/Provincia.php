<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Provincia extends Model
{
    use SoftDeletes;

    protected $table = 'provincia';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected function listDropDown()
    {
        return Provincia::orderBy('nombre', 'asc')->get();
    }
}
