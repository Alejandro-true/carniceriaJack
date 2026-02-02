<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.beans.Autor"%>
<% 
String url = request.getContextPath() + "/";
Autor autor = (Autor) request.getAttribute("autor");
if(autor == null) {
    autor = new Autor();
}
%>

<form action="<%=url%>AutoresController" method="POST" id="formAutor" class="needs-validation" novalidate>
    <!-- IMPORTANTE: Debe ser "modificarAjax" -->
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=autor.getIdAutor()%>">
    
    <div class="mb-3">
        <label for="codigo" class="form-label">
            <i class="fas fa-barcode"></i> Código del Autor <span class="text-danger">*</span>
        </label>
        <input type="text" class="form-control" name="codigo" id="codigo" 
            value="<%=autor.getCodigoAutor() != null ? autor.getCodigoAutor() : ""%>" 
            placeholder="Ej: AUT001" required>
        <div class="invalid-feedback">
            Por favor ingrese el código del autor
        </div>
    </div>
    
    <div class="mb-3">
        <label for="nombre" class="form-label">
            <i class="fas fa-user"></i> Nombre Completo <span class="text-danger">*</span>
        </label>
        <input type="text" class="form-control" name="nombre" id="nombre" 
            value="<%=autor.getNombreAutor() != null ? autor.getNombreAutor() : ""%>" 
            placeholder="Ej: Gabriel García Márquez" required>
        <div class="invalid-feedback">
            Por favor ingrese el nombre del autor
        </div>
    </div>
    
    <div class="mb-3">
        <label for="nacionalidad" class="form-label">
            <i class="fas fa-globe"></i> Nacionalidad <span class="text-danger">*</span>
        </label>
        <input type="text" class="form-control" name="nacionalidad" id="nacionalidad" 
            value="<%=autor.getNacionalidad() != null ? autor.getNacionalidad() : ""%>" 
            placeholder="Ej: Colombiano" required>
        <div class="invalid-feedback">
            Por favor ingrese la nacionalidad
        </div>
    </div>
    
    <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle"></i> 
        Modificando autor ID: <strong><%=autor.getIdAutor()%></strong>
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-warning">
            <i class="fas fa-save"></i> Actualizar Autor
        </button>
    </div>
</form>

<script>
// Activar validación de Bootstrap
(function() {
    'use strict';
    const form = document.getElementById('formAutor');
    if(form) {
        form.classList.add('was-validated');
    }
})();
</script>