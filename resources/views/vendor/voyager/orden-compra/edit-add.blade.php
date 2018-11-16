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
    <link  href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet">
@stop
@section('head')
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
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
                                <div class="col-md-6 form-group">
                                    @php
                                        $field = 'nro_orden_compra';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-6 form-group">
                                    @php
                                        $field = 'fecha';
                                    @endphp
                                    @include('formfields')
                                </div>
                                <div class="col-md-12 form-group">
                                    @php
                                        $field = 'proveedor_id';
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
                                        <th style='vertical-align: middle;'>Cantidad</th>
                                        <th style='vertical-align: middle;'>Precio</th>
                                        <th style='vertical-align: middle; width: 150px;'>
                                            <a href="#modalForm" data-toggle="modal" title="Nuevo" 
                                               data-href="{{ url('orden-compra-linea/create') }}/{{ $dataTypeContent->getKey() }}"
                                               class="btn btn-sm btn-success" style="text-decoration:none;">
                                                    <i class="voyager-plus"></i>
                                            </a>
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
                                        ajax: '{!! url('orden-compra-detalle?parent_id=') !!}{{ $dataTypeContent->getKey() }}',
                                        columns: [
                                            { data: 'rownum',            name: 'rownum', orderable: false, searchable: false },
                                            { data: 'articulo.nombre',   name: 'articulo.nombre' },
                                            { data: 'cantidad',          name: 'cantidad' },
                                            { data: 'precio_formateado', name: 'precio' },
                                            { data: 'action',            name: 'action', orderable: false, searchable: false }
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
                                                targets: [ 2,3 ],
                                                className: 'dt-head-center dt-body-right'
                                            },
                                            {
                                                targets: 4,
                                                className: 'dt-head-center dt-body-center'
                                            }
                                        ]                                    
                                    });
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
                            onclick="ajaxDelete('{{url('orden-compra-linea/delete')}}/'+$('#delete_id').val(),$('#delete_token').val())">>
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
                    $(elt).datetimepicker($(elt).data('datepicker'));
                }
            });

            @if ($isModelTranslatable)
                $('.side-body').multilingual({"editing": true});
            @endif

            $('.side-body input[data-slug-origin]').each(function(i, el) {
                $(el).slugify();
            });

            $('.form-group').on('click', '.remove-multi-image', function (e) {
                e.preventDefault();
                $image = $(this).siblings('img');

                params = {
                    slug:   '{{ $dataType->slug }}',
                    image:  $image.data('image'),
                    id:     $image.data('id'),
                    field:  $image.parent().data('field-name'),
                    _token: '{{ csrf_token() }}'
                }

                $('.confirm_delete_name').text($image.data('image'));
                $('#confirm_delete_modal').modal('show');
            });

            $('#confirm_delete').on('click', function(){
                $.post('{{ route('voyager.media.remove') }}', params, function (response) {
                    if ( response
                        && response.data
                        && response.data.status
                        && response.data.status == 200 ) {

                        toastr.success(response.data.message);
                        $image.parent().fadeOut(300, function() { $(this).remove(); })
                    } else {
                        toastr.error("Error removing image.");
                    }
                });

                $('#confirm_delete_modal').modal('hide');
            });
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
@stop
