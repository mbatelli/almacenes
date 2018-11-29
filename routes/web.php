<?php
use TCG\Voyager\Models\DataType;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'HomeController@index')->name('home');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Route::resource('orden-compra', 'OrdenCompraController');
Route::get('orden-compra-detalle', 'OrdenCompraController@detalle');
Route::match(['get', 'post'], 'orden-compra-linea/create/{id}', 'OrdenCompraController@createLinea');
Route::match(['get', 'put'], 'orden-compra-linea/update/{id}', 'OrdenCompraController@updateLinea');
Route::delete('orden-compra-linea/delete/{id}', 'OrdenCompraController@deleteLinea');

Route::resource('remito', 'RemitoController');
Route::get('remito-detalle', 'RemitoController@detalle');
//Route::get('remito-numero', 'RemitoController@getNumero');
Route::match(['get', 'post'], 'remito-linea/create/{id}', 'RemitoController@createLinea');
Route::match(['get', 'put'], 'remito-linea/update/{id}', 'RemitoController@updateLinea');
Route::delete('remito-linea/delete/{id}', 'RemitoController@deleteLinea');

Route::get('/consulta-existencia', 'ListadoController@consultaExistencia');
Route::get('/puntos-stock-criticos', 'ListadoController@puntosStockCriticos');
Route::get('/listado-valorizacion', 'ListadoController@listadoValorizacion');

$namespacePrefix = '\\'.config('voyager.controllers.namespace').'\\';
try {
    foreach (DataType::all() as $dataType) {
        $breadController = $dataType->controller
                         ? $dataType->controller
                         : $namespacePrefix.'VoyagerBaseController';

        Route::get($dataType->slug.'/order', $breadController.'@order')->name($dataType->slug.'.order');
        Route::post($dataType->slug.'/order', $breadController.'@update_order')->name($dataType->slug.'.order');
        Route::get($dataType->slug.'/{'.$dataType->slug.'}/print', $breadController.'@print')->name($dataType->slug.'.print');
        Route::resource($dataType->slug, $breadController);
    }
} catch (\InvalidArgumentException $e) {
    throw new \InvalidArgumentException("Custom routes hasn't been configured because: ".$e->getMessage(), 1);
} catch (\Exception $e) {
    // do nothing, might just be because table not yet migrated.
}

Route::get('profile_site', ['uses' => $namespacePrefix.'VoyagerController@profileSite', 'as' => 'profile_site']);

Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});