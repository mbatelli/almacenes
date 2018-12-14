<form method="get" class="form-search">
    <div id="search-input">
        <div class="input-group col-md-11">
            <label for="fechaDesde">Desde </label>
            <input type="date" id="fechaDesde" name="fechaDesde" value="@if($fechaDesde){{ $fechaDesde }}@endif">
        </div>
        <div class="input-group col-md-11">
            <label for="fechaHasta">Hasta </label>
            <input type="date" id="fechaHasta" name="fechaHasta" value="@if($fechaHasta){{ $fechaHasta }}@endif">
        </div>
        <div class="input-group col-md-11">
            <label for="articulo">Artículo</label>
            <select id="articulo" name="articulo">
                <?php $articulos = App\Almacenes\Model\Articulo::orderBy('nombre', 'ASC')->get(); ?>
                <option value=""></option>
                @foreach($articulos as $articulo)
                    <option value="{{ $articulo->id }}"@if($selectedArticulo == $articulo->id){{ 'selected="selected"' }}@endif>{{ $articulo->nombre }}</option>
                @endforeach
            </select>
        </div>
    </div>
    <div id="search-input">
        <div class="input-group col-md-11">
            <label for="destinatario">Destinatario</label>
            <select id="destinatario" name="destinatario">
                <?php $destinatarios = App\Almacenes\Model\Destinatario::orderBy('nombre', 'ASC')->get(); ?>
                <option value=""></option>
                @foreach($destinatarios as $destinatario)
                    <option value="{{ $destinatario->id }}"@if($selectedDestinatario == $destinatario->id){{ 'selected="selected"' }}@endif>{{ $destinatario->nombre }}</option>
                @endforeach
            </select>
        </div>
        <div class="input-group col-md-11">
            <label for="proveedor">Proveedor</label>
            <select id="proveedor" name="proveedor">
                <?php $proveedores = App\Almacenes\Model\Proveedor::orderBy('nombre', 'ASC')->get(); ?>
                <option value=""></option>
                @foreach($proveedores as $proveedor)
                    <option value="{{ $proveedor->id }}"@if($selectedProveedor == $proveedor->id){{ 'selected="selected"' }}@endif>{{ $proveedor->nombre }}</option>
                @endforeach
            </select>
        </div>
        <div class="input-group col-md-1">
            <span class="input-group-btn">
                <button class="btn btn-info btn-lg" type="submit">
                    <i class="voyager-search"></i>
                </button>
            </span>
        </div>
    </div>
</form>