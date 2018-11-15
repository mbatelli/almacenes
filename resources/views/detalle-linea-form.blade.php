@if(!is_null($dataTypeContent->getKey()))
    {!! Form::model($dataTypeContent,['method'=>'put','id'=>'frmTbl']) !!}
@else
    {!! Form::open(['id'=>'frmTbl']) !!}
@endif

<div class="modal-header">
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i>
        {{ __('voyager::generic.'.(!is_null($dataTypeContent->getKey()) ? 'edit' : 'add')).' '.$dataType->display_name_singular }}
    </h1>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body">
    @if (count($errors) > 0)
        <div class="alert alert-danger">
            <ul>
                @foreach ($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    @endif

    <!-- Adding / Editing -->
    @php
        $dataTypeRows = $dataType->{(!is_null($dataTypeContent->getKey()) ? 'editRows' : 'addRows' )};
    @endphp

    @foreach($dataTypeRows as $row)
        <!-- GET THE DISPLAY OPTIONS -->
        @php
            $options = json_decode($row->details);
            $display_options = isset($options->display) ? $options->display : NULL;
        @endphp
        @if ($options && isset($options->legend) && isset($options->legend->text))
            <legend class="text-{{isset($options->legend->align) ? $options->legend->align : 'center'}}" style="background-color: {{isset($options->legend->bgcolor) ? $options->legend->bgcolor : '#f0f0f0'}};padding: 5px;">{{$options->legend->text}}</legend>
        @endif
        @if ($options && isset($options->formfields_custom))
            @include('voyager::formfields.custom.' . $options->formfields_custom)
        @else
            <div class="form-group row">
                <div class="@if($row->type == 'hidden') hidden @endif col-md-{{ isset($display_options->width) ? $display_options->width : 12 }}" @if(isset($display_options->id)){{ "id=$display_options->id" }}@endif>
                    {{ $row->slugify }}
                    <label for="name">{{ $row->display_name }}</label>
                    @include('voyager::multilingual.input-hidden-bread-edit-add')
                    @if($row->type == 'relationship')
                        @include('voyager::formfields.relationship')
                    @else
                        {!! app('voyager')->formField($row, $dataType, $dataTypeContent) !!}
                    @endif

                    @foreach (app('voyager')->afterFormFields($row, $dataType, $dataTypeContent) as $after)
                        {!! $after->handle($row, $dataType, $dataTypeContent) !!}
                    @endforeach
                </div>
            </div>
        @endif
    @endforeach
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-danger" data-dismiss="modal"> Cerrar</button>
    {!! Form::submit("Grabar",["class"=>"btn btn-primary"])!!}
</div>
{!! Form::close() !!}