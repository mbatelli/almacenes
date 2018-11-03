<?php

namespace App\Almacenes\Actions;
use TCG\Voyager\Actions\DeleteAction as VoyagerDeleteAction;

class DeleteAction extends VoyagerDeleteAction
{
    public function isDeleted() {
        return isset($this->data->deleted_at);
    }

    public function getTitle()
    {
        return $this->isDeleted() ? __('voyager::generic.restore') : __('voyager::generic.delete');
    }

    public function getIcon()
    {
        return $this->isDeleted() ? 'voyager-refresh' : 'voyager-trash';
    }

    public function getPolicy()
    {
        return parent::getPolicy();
    }

    public function getAttributes()
    {
        return [
            'class'   => $this->isDeleted() ? 'btn btn-sm btn-danger pull-right restore' : 'btn btn-sm btn-danger pull-right delete',
            'data-id' => $this->data->{$this->data->getKeyName()},
            'id'      => ($this->isDeleted() ? 'restore-' : 'delete-').$this->data->{$this->data->getKeyName()},
        ];
    }

    public function getDefaultRoute()
    {
        return 'javascript:;';
    }
}
