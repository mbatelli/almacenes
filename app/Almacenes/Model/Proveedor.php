<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Proveedor extends Model
{
    protected $table = 'proveedor';
    
    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function ciudadId()
    {
        return $this->belongsTo('App\Almacenes\Model\Ciudad');
    }
}
