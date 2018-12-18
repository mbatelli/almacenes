@php
    $row = $dataTypeRows->first(function ($value) use ($field) {
                            return $value->field == $field;
                        });
    $options = json_decode($row->details);
    $display_options = isset($options->display) ? $options->display : NULL;
@endphp
{{ $row->slugify }}
@if($row->type != 'hidden')
    <label for="name">{{ $row->display_name }}</label>
@endif
@include('voyager::multilingual.input-hidden-bread-edit-add')
@if($row->type == 'relationship')
    @include('voyager::formfields.relationship')
@else
    {!! app('voyager')->formField($row, $dataType, $dataTypeContent) !!}
@endif

@foreach (app('voyager')->afterFormFields($row, $dataType, $dataTypeContent) as $after)
    {!! $after->handle($row, $dataType, $dataTypeContent) !!}
@endforeach
