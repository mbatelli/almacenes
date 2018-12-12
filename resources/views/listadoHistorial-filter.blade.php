<form method="get" class="form-search">
    <div id="search-input">
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
        <div class="input-group col-md-1">
            <span class="input-group-btn">
                <button class="btn btn-info btn-lg" type="submit">
                    <i class="voyager-search"></i>
                </button>
            </span>
        </div>
    </div>
</form>
