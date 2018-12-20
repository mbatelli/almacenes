<?php

namespace App\Almacenes\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Ciudad extends Model
{
    use SoftDeletes;

    protected $table = 'ciudad';
    protected $dates = ['created_at', 'updated_at', 'deleted_at'];

    protected function listDropDown()
    {
        return Ciudad::whereNull('deleted_at')->orderBy('nombre', 'asc')->get();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function provinciaId()
    {
        return $this->belongsTo('App\Almacenes\Model\Provincia');
    }
}
