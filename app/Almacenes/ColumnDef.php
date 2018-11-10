<?php

namespace App\Almacenes;

class ColumnDef {
    public $name;
    public $title;

    public function  __construct($name, $title) {
        $this->name = $name;
        $this->title = $title;
    }

    public function isCurrentSortField() {
        return false;
    }
}
