@if(isset($ordenCompraLinea))
    {!! Form::model($ordenCompraLinea,['method'=>'put','id'=>'frm']) !!}
@else
    {!! Form::open(['id'=>'frm']) !!}
@endif
<div class="modal-header">
    <h5 class="modal-title">{{isset($ordenCompraLinea)?'Editar':'Nueva'}} Línea</h5>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body">
<!-- 
    <div class="form-group row required">
        {!! Form::label("articulo","Articulo",["class"=>"col-form-label col-md-3"]) !!}
        <div class="col-md-9">
            {!! Form::select("articulo", App\Almacenes\Model\Articulo::pluck('nombre', 'id'), null, ["class"=>"form-control".($errors->has('articulo')?" is-invalid":"")]) !!}
            <span id="error-name" class="invalid-feedback"></span>
        </div>
    </div>
-->
    <div class="form-group row required">
        {!! Form::label("cantidad","Cantidad",["class"=>"col-form-label col-md-3"]) !!}
        <div class="col-md-9">
            {!! Form::text("cantidad",null,["class"=>"form-control".($errors->has('cantidad')?" is-invalid":""),'placeholder'=>'Cantidad','id'=>'focus']) !!}
            <span id="error-name" class="invalid-feedback"></span>
        </div>
    </div>
    <div class="form-group row">
        {!! Form::label("precio","Precio",["class"=>"col-form-label col-md-3"]) !!}
        <div class="col-md-9">
            {!! Form::text("precio",null,["class"=>"form-control".($errors->has('precio')?" is-invalid":""),'placeholder'=>'Precio','id'=>'focus']) !!}
            <span id="error-name" class="invalid-feedback"></span>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-danger" data-dismiss="modal"> Cerrar</button>
    {!! Form::submit("Grabar",["class"=>"btn btn-primary"])!!}
</div>
{!! Form::close() !!}