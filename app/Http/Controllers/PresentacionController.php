<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Voyager\VoyagerBaseController;
use Validator;

class PresentacionController extends VoyagerBaseController
{
    public function validateBread($request, $data, $name = null, $id = null)
    {
        $rules = [];
        $messages = [];
        $customAttributes = [];
        $is_update = $name && $id;

        $fieldsWithValidationRules = $this->getFieldsWithValidationRules($data);

        foreach ($fieldsWithValidationRules as $field) {
            $options = json_decode($field->details);
            $fieldRules = $options->validation->rule;
            $fieldName = $field->field;

            // Show the field's display name on the error message
            if (!empty($field->display_name)) {
                $customAttributes[$fieldName] = $field->display_name;
            }

            // Get the rules for the current field whatever the format it is in
            $rules[$fieldName] = is_array($fieldRules) ? $fieldRules : explode('|', $fieldRules);

            // Fix Unique validation rule on Edit Mode
            if ($is_update) {
                foreach ($rules[$fieldName] as &$fieldRule) {
                    if (strpos(strtoupper($fieldRule), 'UNIQUE') !== false) {
                        $fieldRule = \Illuminate\Validation\Rule::unique($name)->ignore($id);
                    }
                }
            }

            // Set custom validation messages if any
            if (!empty($options->validation->messages)) {
                foreach ($options->validation->messages as $key => $msg) {
                    $messages["{$fieldName}.{$key}"] = $msg;
                }
            }
        }

        return Validator::make($request, $rules, $messages, $customAttributes);
    }    
}
