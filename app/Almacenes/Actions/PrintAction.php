<?php

namespace App\Almacenes\Actions;
use TCG\Voyager\Actions\AbstractAction;

class PrintAction extends AbstractAction
{
    public function getTitle()
    {
        return __('voyager::generic.print');
    }

    public function getIcon()
    {
        return 'voyager-receipt';
    }

    public function getPolicy()
    {
        return 'read';
    }

    public function getAttributes()
    {
        return [
            'class'   => 'btn btn-sm btn-danger pull-right print'
        ];
    }

    public function getDefaultRoute()
    {
        return route($this->dataType->slug.'.print', $this->data->{$this->data->getKeyName()});
    }

    public function shouldActionDisplayOnDataType()
    {
        if(!method_exists ($this->data, 'showPrintAction' ) || method_exists ($this->data, 'showPrintAction' ) && $this->data->showPrintAction())
            return parent::shouldActionDisplayOnDataType();
        return  false;
    }    
}
