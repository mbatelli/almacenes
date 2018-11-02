<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;


class Ciudad extends Model
{
    protected $table = 'ciudad';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function provinciaId()
    {
        return $this->belongsTo('App\Almacenes\Model\Provincia');
    }

    protected function listDropDown()
    {
        return Ciudad::orderBy('nombre', 'asc')->get();
    }
}
