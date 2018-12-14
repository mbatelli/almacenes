@extends('master')

@section('page_title', __('voyager::generic.viewing').' '.$queryDef->queryName)

@section('page_header')
    <div class="container-fluid">
        <h1 class="page-title">
            <i class="{{ $queryDef->icon }}"></i> {{ $queryDef->queryName }}
        </h1>
    </div>
@stop

@section('content')
    <div class="page-content browse container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <div class="panel-body">
                        @if ($isWithFilter)
                            @include($filter)
                        @endif
                        <div class="table-responsive">
                            <table id="dataTable" class="table table-hover">
                                <thead>
                                    <tr>
                                        @foreach($queryDef->columns as $row)
                                        <th>
                                            {{ $row->title }}
                                        </th>
                                        @endforeach
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($queryDef->data as $data)
                                    <tr>
                                        @foreach($queryDef->columns as $row)
                                            <td>
                                                <span>{{ $data->values[$row->name] }}</span>
                                            </td>
                                        @endforeach
                                    </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop

@section('javascript')
    <!-- DataTables -->
    <script src="{{ asset('js/datatables.min.js') }}"></script>
    <script>
        $(document).ready(function () {
            var elem = document.createElement('textarea');
            elem.innerHTML = '{{ $filterInfo }}';
            var filterInfo = elem.value;
            $('#dataTable').DataTable({
                        language: {
                            url: '/i18n/datatables/spanish.json'
                        },
                        paging: false,
                        processing: true,
                        dom: 'Bfrtip',
                        buttons: [
                            {
                                text: 'PDF',
                                extend: 'pdfHtml5',
                                customize: function (doc) {
                                    doc['header']=(function(page, pages) {
                                        return {
                                            columns: [
                                                filterInfo
                                            ],
                                            margin: [10, 0]
                                        }
                                    });
                                    doc['footer']=(function(page, pages) {
                                        return {
                                            columns: [
                                                {
                                                    // This is the right column
                                                    alignment: 'right',
                                                    text: ['Página ', { text: page.toString() },  ' de ', { text: pages.toString() }]
                                                }
                                            ],
                                            margin: [10, 0]
                                        }
                                    });
                                },
                            },
                            'excel'
                        ],
                    });            
            /*
            var table = $('#dataTable').DataTable({!! json_encode(
                array_merge([
                    "order" => [],
                    "language" => __('voyager::datatable'),
                    "dom" => 'Bfrtip',
                    "buttons" => ['pdf', 'excel'],
                ],
                config('voyager.dashboard.data_tables', []))
            , true) !!});
            */
        });
    </script>
@stop
