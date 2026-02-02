<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getContextPath() + "/";
%>

<form action="<%=url%>AutoresController" method="POST" id="formAutor">
    <input type="hidden" name="op" value="insertarAjax">
    
    <div class="mb-3">
        <label for="codigo" class="form-label">
            Código del Autor <span class="text-danger">*</span>
        </label>
        <input type="text" class="form-control" name="codigo" id="codigo" 
            placeholder="Ejemplo: AUT001" required>
    </div>
    
    <div class="mb-3">
        <label for="nombre" class="form-label">
            Nombre Completo <span class="text-danger">*</span>
        </label>
        <input type="text" class="form-control" name="nombre" id="nombre" 
            placeholder="Ejemplo: Gabriel Garcia Marquez" required>
    </div>
    
    <div class="mb-3">
        <label for="nacionalidad" class="form-label">
            Nacionalidad <span class="text-danger">*</span>
        </label>
        <input type="text" class="form-control" name="nacionalidad" id="nacionalidad" 
            placeholder="Ejemplo: Colombiano" required>
    </div>
    
    <div class="d-grid gap-2">
        <input type="submit" class="btn btn-primary" value="Guardar">
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