<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Deposito extends Model
{
    use SoftDeletes;

    protected $table = 'deposito';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];
    
    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function ciudadId()
    {
        return $this->belongsTo('App\Almacenes\Model\Ciudad','ciudad_id');
    }

    protected function listDropDown()
    {
        return Deposito::orderBy('nombre', 'asc')->get();
    }
}
