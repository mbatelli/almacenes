<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Deposito extends Model
{
    protected $table = 'deposito';
    
    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function ciudadId()
    {
        return $this->belongsTo('App\Almacenes\Model\Ciudad');
    }

    protected function listDropDown()
    {
        return Deposito::orderBy('nombre', 'asc')->get();
    }
}
