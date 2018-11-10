<?php

namespace App\Almacenes;

class QueryDef {
    public $icon;
    public $queryName;
    public $columns;
    public $data = [];

    public function  __construct($icon, $queryName, $columns, $data) {
        $this->icon = $icon;
        $this->queryName = $queryName;
        $this->columns = $columns;
        $this->data = $data;
      }
}
