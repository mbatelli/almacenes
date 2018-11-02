<?php

namespace App\Almacenes\Actions;

use TCG\Voyager\Actions\AbstractAction;

class RestoreAction extends AbstractAction
{
    public function getTitle()
    {
        return __('voyager::generic.restore');
    }

    public function getIcon()
    {
        return 'voyager-refresh';
    }

    public function getPolicy()
    {
        return 'delete';
    }

    public function getAttributes()
    {
        return [
            'class'   => 'btn btn-sm btn-danger pull-right delete',
            'data-id' => $this->data->{$this->data->getKeyName()},
            'id'      => 'restore-'.$this->data->{$this->data->getKeyName()},
        ];
    }

    public function getDefaultRoute()
    {
        return 'javascript:;';
    }
}
