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
}
