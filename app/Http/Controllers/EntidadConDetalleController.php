<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use TCG\Voyager\Facades\Voyager;
use App\Http\Controllers\Voyager\VoyagerBaseController;

class EntidadConDetalleController extends VoyagerBaseController
{
    protected function getValidationRules() {
        return [];
    }

    protected function createEntidad(Request $request, $parentId) {

    }

    protected function saveEntidad(Request $request, $linea) {

    }

    protected function getLinea($id) {

    }

    protected function getAttributeNames() {
        
    }

    public function createLinea(Request $request, $parentId)
    {
        if ($request->isMethod('get')) {
            $slug = $this->getSlug($request);

            $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

            $relationships = $this->getRelationships($dataType);

            // Check permission
            $this->authorize('add', app($dataType->model_name));

            $dataTypeContent = (strlen($dataType->model_name) != 0)
                                ? new $dataType->model_name()
                                : false;

            foreach ($dataType->editRows as $key => $row) {
                $details = json_decode($row->details);
                $dataType->editRows[$key]['col_width'] = isset($details->width) ? $details->width : 100;
            }

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'add');

            // Check if BREAD is Translatable
            $isModelTranslatable = is_bread_translatable($dataTypeContent);

            $view = 'detalle-linea-form';

            return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
        } else { // POST
            $rules = $this->getValidationRules();
            $validator = Validator::make($request->all(), $rules);
            $validator->setAttributeNames($this->getAttributeNames());
            if ($validator->fails()) {
                return response()->json([
                    'fail' => true,
                    'errors' => $validator->errors()
                ]);
            }

            $this->createEntidad($request, $parentId);
            return response()->json([
                'fail' => false,
                'table_refresh' => 'detalle-table'
            ]);
        }
    }

    private function editLinea(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $relationships = $this->getRelationships($dataType);

        $dataTypeContent = (strlen($dataType->model_name) != 0)
                ? app($dataType->model_name)->with($relationships)->findOrFail($id)
                : DB::table($dataType->name)->where('id', $id)->first(); // If Model doest exist, get data from table name

        foreach ($dataType->editRows as $key => $row) {
            $details = json_decode($row->details);
            $dataType->editRows[$key]['col_width'] = isset($details->width) ? $details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'edit');

        // Check permission
        $this->authorize('edit', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'detalle-linea-form';

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
    }

    public function updateLinea(Request $request, $id)
    {
        if ($request->isMethod('get'))
            return $this->editLinea($request, $id);
        else {
            $rules = $this->getValidationRules();
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) {
                return response()->json([
                    'fail' => true,
                    'errors' => $validator->errors()
                ]);
            }
            $this->saveEntidad($request, $this->getLinea($id));
            return response()->json([
                'fail' => false,
                'table_refresh' => 'detalle-table'
            ]);
        }
    }

    public function deleteLinea($id)
    {
        $linea = $this->getLinea($id);
        $linea->delete();
        return response()->json([
            'fail' => false,
            'table_refresh' => 'detalle-table'
        ]);
    }
}
