@extends('master')

@section('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <style>
        .loading {
            background: lightgrey;
            padding: 15px;
            position: fixed;
            border-radius: 4px;
            left: 50%;
            top: 50%;
            text-align: center;
            margin: -40px 0 0 -50px;
            z-index: 2000;
            display: none;
        }

        a, a:hover {
            color: white;
        }

        .form-group.required label:after {
            content: " *";
            color: red;
            font-weight: bold;
        }

        .table-title {
            display: inline-block;
            font-size: 18px;
            height: 100px;
            line-height: 43px;
            margin-top: 3px;
            padding-top: 28px;
            color: #555;
            position: relative;
            padding-left: 15px;
            font-weight: 700;
            margin-right: 20px;
        }       
    </style>
@stop

@section('page_title', __('voyager::generic.'.(!is_null($dataTypeContent->getKey()) ? 'edit' : 'add')).' '.$dataType->display_name_singular)

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i>
        {{ __('voyager::generic.'.(!is_null($dataTypeContent->getKey()) ? 'edit' : 'add')).' '.$dataType->display_name_singular }}
    </h1>
    @include('voyager::multilingual.language-selector')
@stop

@section('css')
    <link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet">
@stop
@section('head')
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
@stop

@section('content')
    <div class="page-content container-fluid">
        <div class="row">
            <div class="col-md-12">
                <!-- form start -->
                <form role="form"
                        class="form-edit-add"
                        action="@if(!is_null($dataTypeContent->getKey())){{ route($dataType->slug.'.update', $dataTypeContent->getKey()) }}@else{{ route('voyager.'.$dataType->slug.'.store') }}@endif"
                        method="POST" enctype="multipart/form-data">
                    <!-- PUT Method if we are editing -->
                    @if(!is_null($dataTypeContent->getKey()))
                        {{ method_field("PUT") }}
                    @endif

                    <!-- CSRF TOKEN -->
                    {{ csrf_field() }}

                    @if (count($errors) > 0)
                        <div class="panel panel-primary panel-bordered">
                            <div class="alert alert-danger">
                                <ul>
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        </div>
                    @endif

                    <!-- Adding / Editing -->
                    @php
                        $dataTypeRows = $dataType->{(!is_null($dataTypeContent->getKey()) ? 'editRows' : 'addRows' )};
                    @endphp

                    <div class="panel-footer">
                        <button type="button" onclick="window.location='{{ URL::route($dataType->slug.'.index') }}'" class="btn btn-primary save">{{ __('voyager::generic.close') }}</button>
                    </div>
                    
                    <div class="panel panel-primary panel-bordered">
                        <div class="panel-heading">
                            <h3 class="panel-title panel-icon">Datos</h3>
                            <div class="panel-actions">
                                <a class="panel-action voyager-angle-up" data-toggle="panel-collapse" aria-hidden="true"></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row clearfix">
                                @php
                                    $field = 'id';
                                @endphp
                                @include('formfields')

                                <div class="col-md-2 form-group">
                                    @php
                                        $field = 'tipo';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-4 form-group">
                                    @php
                                        $field = 'deposito_id';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-2 form-group">
                                    @php
                                        $field = 'punto_venta';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-2 form-group">
                                    @php
                                        $field = 'numero';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-2 form-group">
                                    @php
                                        $field = 'fecha';
                                    @endphp
                                    @include('formfields')
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="panel_entrada" class="panel panel-primary panel-bordered">
                        <div class="panel-heading">
                            <h3 class="panel-title panel-icon">Entrada</h3>
                            <div class="panel-actions">
                                <a class="panel-action voyager-angle-up" data-toggle="panel-collapse" aria-hidden="true"></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row clearfix">
                                <div class="col-md-6 form-group">
                                    @php
                                        $field = 'proveedor_id';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-6 form-group">
                                    @php
                                        $field = 'orden_compra_id';
                                    @endphp
                                    @include('formfields')
                                </div>
                            </div>
                            <div class="row clearfix">
                                <div class="col-md-12 form-group">
                                    @php
                                        $field = 'nota';
                                    @endphp
                                    @include('formfields')
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="panel_salida" class="panel panel-primary panel-bordered">
                        <div class="panel-heading">
                            <h3 class="panel-title panel-icon">Salida</h3>
                            <div class="panel-actions">
                                <a class="panel-action voyager-angle-up" data-toggle="panel-collapse" aria-hidden="true"></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row clearfix">
                                <div class="col-md-6 form-group">
                                    @php
                                        $field = 'proceso_electoral_id';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-6 form-group">
                                    @php
                                        $field = 'destinatario_id';
                                    @endphp
                                    @include('formfields')
                                </div>
                            </div>
                            <div class="row clearfix">
                                <div class="col-md-3 form-group">
                                    @php
                                        $field = 'transportador';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-2 form-group">
                                    @php
                                        $field = 'patente';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-3 form-group">
                                    @php
                                        $field = 'conductor';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-2 form-group">
                                    @php
                                        $field = 'dni';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-2 form-group">
                                    @php
                                        $field = 'telefono';
                                    @endphp
                                    @include('formfields')
                                </div>
                            </div>
                            <div class="row clearfix">
                                <div class="col-md-1 form-group">
                                    @php
                                        $field = 'cantidad_bultos';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-1 form-group">
                                    @php
                                        $field = 'peso';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-1 form-group">
                                    @php
                                        $field = 'volumen';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-3 form-group">
                                    @php
                                        $field = 'precintos';
                                    @endphp
                                    @include('formfields')
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-footer">
                        <button type="submit" class="btn btn-primary save">{{ __('voyager::generic.save') }}</button>
                    </div>

                    @if(!is_null($dataTypeContent->getKey()))
                    <div class="panel panel-primary panel-bordered" style="margin-top: 20px;">
                        <div class="panel-heading">
                            <h3 class="panel-title panel-icon">Detalle</h3>
                            <div class="panel-actions">
                                <a class="panel-action voyager-angle-up" data-toggle="panel-collapse" aria-hidden="true"></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <table id="detalle-table" class="table table-bordered compact stripe" style="width:100%">
                                <thead>
                                    <tr>
                                        <th style='vertical-align: middle; width: 50px;'>#</th>
                                        <th style='vertical-align: middle;'>Artículo</th>
                                        <th style='vertical-align: middle; width:50px;'>Cantidad</th>
                                        <th style='vertical-align: middle;'>Presentación</th>
                                        <th style='vertical-align: middle; width: 150px;'>
                                            <span class='btn btn-sm'>
                                                <input type="checkbox" name='row_select' data-id='ALL' title='Selecciona todas las filas' onclick='onRowSelect(this)'/>
                                            </span>
                                            <a href="#modalForm" data-toggle="modal" title="Nuevo" 
                                               data-href="{{ url('remito-linea/create') }}/{{ $dataTypeContent->getKey() }}"
                                               class="btn btn-sm btn-success" style="text-decoration:none;">
                                                    <i class="voyager-plus"></i>
                                            </a>
                                            <span class='btn btn-sm'>
                                            </span>
                                        </th>
                                    </tr>
                                </thead>
                            </table>

                            <div class="loading">
                                <i class="fa fa-refresh fa-spin fa-2x fa-fw"></i><br/>
                                <span>Cargando</span>
                            </div>

                            <script>
                                $(function() {
                                    $('#detalle-table').DataTable({
                                        language: {
                                            url: '/i18n/datatables/spanish.json'
                                        },
                                        paging: false,
                                        processing: true,
                                        serverSide: true,
                                        ajax: '{!! url('remito-detalle?parent_id=') !!}{{ $dataTypeContent->getKey() }}',
                                        columns: [
                                            { data: 'rownum',               name: 'rownum', orderable: false, searchable: false },
                                            { data: 'articulo.nombre',      name: 'articulo.nombre' },
                                            { data: 'cantidad',             name: 'cantidad' },
                                            { data: 'presentacion.nombre',  name: 'presentacion.nombre', defaultContent: '<i>Sin especificar</i>' },
                                            { data: 'action',               name: 'action', orderable: false, searchable: false }
                                        ],
                                        columnDefs: [
                                            {
                                                targets: 0,
                                                className: 'dt-head-center dt-body-right'
                                            },
                                            {
                                                targets: 1,
                                                className: 'dt-head-center dt-body-left'
                                            },
                                            {
                                                targets: 2,
                                                className: 'dt-head-center dt-body-right'
                                            },
                                            {
                                                targets: 3,
                                                className: 'dt-head-center dt-body-left'
                                            },
                                            {
                                                targets: 4,
                                                className: 'dt-head-center dt-body-center'
                                            }
                                        ]                                    
                                    })
                                    .on('draw', onLoadedData);
                                });
                            </script>

                        </div>
                    </div>
                    @endif
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" data-backdrop="static">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="modal_content"></div>
        </div>
    </div>
    
    <div class="modal fade modal-danger" id="modalDelete">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="voyager-warning"></i> {{ __('voyager::generic.are_you_sure') }}</h4>
                </div>

                <div class="modal-body">
                    <h4>{{ __('voyager::generic.are_you_sure_delete_r') }} <span id="delete_nombre" class="confirm_delete_name"></span></h4>
                    <input type="hidden" id="delete_token"/>
                    <input type="hidden" id="delete_id"/>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
                    <button type="button" class="btn btn-danger" id="confirm_delete"
                            onclick="ajaxDelete('{{url('remito-linea/delete')}}/'+$('#delete_id').val(),$('#delete_token').val())">>
                            {{ __('voyager::generic.delete_confirm') }}</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade modal-danger" id="confirm_delete_modal">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="voyager-warning"></i> {{ __('voyager::generic.are_you_sure') }}</h4>
                </div>

                <div class="modal-body">
                    <h4>{{ __('voyager::generic.are_you_sure_delete') }} '<span class="confirm_delete_name"></span>'</h4>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
                    <button type="button" class="btn btn-danger" id="confirm_delete">{{ __('voyager::generic.delete_confirm') }}</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Delete File Modal -->
@stop

@section('javascript')
    <script src="{{asset('js/ajax-crud-modal-form.js')}}"></script>

    <script>
        var params = {};
        var $image;

        $('document').ready(function () {
            $('.toggleswitch').bootstrapToggle();

            //Init datepicker for date fields if data-datepicker attribute defined
            //or if browser does not handle date inputs
            $('.form-group input[type=date]').each(function (idx, elt) {
                if (elt.type != 'date' || elt.hasAttribute('data-datepicker')) {
                    elt.type = 'text';
                    try{
                    $(elt).datetimepicker($(elt).data('datepicker'));
                    } catch(e){}
                }
            });

            $('.side-body input[data-slug-origin]').each(function(i, el) {
                $(el).slugify();
            });

            $('[data-toggle="tooltip"]').tooltip();

            // Manejo de solo lectura
            handleReadonly($('select[name=tipo]').val());
            // Manejo de visibilidad
            handleVisibility($('select[name=tipo]').val());
            $('select[name=tipo]').on('change', function() {
                handleVisibility(this.value);
                handleReadonly(this.value);

                handleVisibilityRowSelect();
            });
            handleVisibilityRowSelect();
        });
        function onPostLoadPopup() {
            $('#frmTbl select[name=articulo_id]').on('change', onChangeArticulo);
            // Ejecuto para que cargue la 1ra vez si es edición
            onChangeArticulo();
        }
        function onPostDeleteDetalle() {
            onPostSubmitPopup();
        }
        function onPostSubmitPopup() {
            $('.loading').show();
            $.ajax({
                type: 'GET',
                url: '{{url("remito-update-salida")}}',
                data: {
                    'remitoId': $('input[name=id]').val()
                },
                success: function (data) {
                    $('input[name=cantidad_bultos]').val(data.bultos);
                    $('input[name=peso]').val(data.peso);
                    $('input[name=volumen]').val(data.volumen);
                    $('.loading').hide();
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert("Error: " + errorThrown);
                }
            });            
        }
        // Cargamos las presentaciones del artículo
        function onChangeArticulo() {
            $('.loading').show();
            $.ajax({
                type: 'GET',
                url: '{{url("remito-detalle-change-articulo")}}',
                data: {
                    'remitoLineaId': $('#frmTbl input[name=id]').val(),
                    'articuloId': $('#frmTbl select[name=articulo_id]').val()
                },
                success: function (data) {
                    $('#frmTbl select[name=presentacion_id]').children('option').remove();
                    $('#frmTbl select[name=presentacion_id]')
                            .append($("<option></option>")
                            .attr("value", '')
                            .text('-- Seleccionar'));
                    $.each(data.selectValues, function(idx, value) {
                        $('#frmTbl select[name=presentacion_id]')
                            .append($("<option></option>")
                            .attr("value", value.id)
                            .text(value.nombre));
                    });
                    $('#frmTbl select[name=presentacion_id] option[value=' + (data.selectedValue != null ? data.selectedValue : data.defaultValue) + ']').attr('selected','selected');
                    $('.loading').hide();
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert("Error: " + errorThrown);
                }
            });            
        }
        function handleReadonly(tipoRemito) {
            switch(tipoRemito) {
                case 'REMITO_SALIDA':
                case 'PROVISORIO_SALIDA':
                case 'COMPROBANTE_AJUSTE':
                    $('input[name=punto_venta]').prop('readonly', true);
                    $('input[name=numero]').prop('readonly', true);
                    break;
                case 'REMITO_ENTRADA':
                    $('input[name=punto_venta]').prop('readonly', false);
                    $('input[name=numero]').prop('readonly', false);
                    break;
            }
        }
        function handleVisibility(tipoRemito) {
            switch(tipoRemito) {
                case 'REMITO_SALIDA':
                case 'PROVISORIO_SALIDA':
                    $("div#panel_entrada").hide();
                    $("div#panel_salida").show();
                    break;
                case 'REMITO_ENTRADA':
                    $("div#panel_entrada").show();
                    $("div#panel_salida").hide();
                    break;
                case 'COMPROBANTE_AJUSTE':
                    $("div#panel_entrada").hide();
                    $("div#panel_salida").hide();
                    break;
            }
        }
        function handleVisibilityRowSelect() {
            var rows = $('#detalle-table input[name=row_select]');
            if($('select[name=tipo]').val() == 'PROVISORIO_SALIDA') {
                rows.show();
            } else
                rows.hide();
        }
        function onRowSelect(obj) {
            var rows = $('#detalle-table input[name=row_select]');
            if(obj.attributes['data-id'].value == 'ALL') {
                for(var i = 1; i < rows.length; ++i)
                    rows[i].checked = rows[0].checked;
            } else {
                var allChk = true;
                for(var i = 1; i < rows.length; ++i) {
                    if(!rows[i].checked) {
                        allChk = false;
                        break;
                    }
                }
                rows[0].checked = allChk;
            }
        }
        function getRowSelectIds() {
            var rows = $('#detalle-table input[name=row_select]');
            var ids = [];
            for(var i = 1; i < rows.length; ++i) {
                if(rows[i].checked)
                    ids.push(rows[i].attributes['data-id'].value);
            }
            return ids;
        }

        function onLoadedData(a) {
            handleVisibilityRowSelect();
        }
    </script>
@stop
