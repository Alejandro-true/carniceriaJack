<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Producto"%>
<%@ page import="com.unu.poowebmodalga.beans.Categoria"%>
<%
String url = request.getContextPath() + "/";
Producto producto = (Producto) request.getAttribute("producto");
List<Categoria> listaCategoria = (List<Categoria>) request.getAttribute("listaCategoria");
if(producto == null) {
	producto = new Producto();
}
%>

<form action="<%=url%>ProductoController" method="POST" id="formProducto" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=producto.getIdProducto()%>">
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="nombre" class="form-label">
                <i class="fas fa-book"></i> Nombre del Producto <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombre" id="nombre" 
                value="<%=producto.getNombreProducto() != null ? producto.getNombreProducto() : ""%>" 
                placeholder="Ej: Cien años de soledad" required>
            <div class="invalid-feedback">
                Por favor ingrese el Nombre del Producto
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="autor" class="form-label">
                <i class="fas fa-user"></i> Categoria <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="categoria" id="categoria" required>
                <option value="">Seleccione una categoria...</option>
                <%
                if (listaCategoria != null && !listaCategoria.isEmpty()) {
                                                    for (Categoria categoria : listaCategoria) {
                                                        String selected = (producto.getIdCategoria() == categoria.getIdCategoria()) ? "selected" : "";
                %>
                <option value="<%=categoria.getIdCategoria()%>" <%=selected%>>
                    <%=categoria.getNombreCategoria()%>
                </option>
                <%
                }
                                } else {
                %>
                <option value="" disabled>No hay categorias disponibles</option>
                <%
                }
                %>
            </select>
            <div class="invalid-feedback">
                Por favor seleccione una Categoria
            </div>
        </div>
        
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="existencia" class="form-label">
                <i class="fas fa-boxes"></i> Stock <span class="text-danger">*</span>
            </label>
            <input type="number" class="form-control" name="stock" id="stock" 
                value="<%=producto.getStock()%>" 
                placeholder="Ej: 10" min="0" required>
            <div class="invalid-feedback">
                Por favor ingrese el stock
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <label for="precio" class="form-label">
                <i class="fas fa-dollar-sign"></i> Precio <span class="text-danger">*</span>
            </label>
            <input type="number" class="form-control" name="precio" id="precio" 
                value="<%=producto.getPrecioUnitario()%>" 
                placeholder="Ej: 25.50" step="0.01" min="0" required>
            <div class="invalid-feedback">
                Por favor ingrese el precio unitario
            </div>
        </div>
    </div>
    
    
    
    <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle"></i> 
        Modificando producto ID: <strong><%=producto.getIdProducto()%></strong>
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-warning">
            <i class="fas fa-save"></i> Actualizar Producto
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    const form = document.getElementById('formProducto');
    if(form) {
        form.classList.add('was-validated');
    }
})();
</script>