<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getContextPath() + "/";
%>

<form action="<%=url%>UsuariosController" method="POST" id="formUsuario" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="insertarAjax">
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="nombreUsuario" class="form-label">
                <i class="fas fa-user"></i> Nombre de Usuario <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreUsuario" id="nombreUsuario" 
                placeholder="Ej: jperez" required pattern="[a-zA-Z0-9_]{4,20}"
                title="4-20 caracteres, solo letras, números y guión bajo">
            <div class="invalid-feedback">
                Usuario debe tener 4-20 caracteres (letras, números, _)
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <label for="password" class="form-label">
                <i class="fas fa-lock"></i> Contraseña <span class="text-danger">*</span>
            </label>
            <input type="password" class="form-control" name="password" id="password" 
                placeholder="Mínimo 6 caracteres" required minlength="6">
            <div class="invalid-feedback">
                La contraseña debe tener al menos 6 caracteres
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="nombreCompleto" class="form-label">
                <i class="fas fa-id-card"></i> Nombre Completo <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreCompleto" id="nombreCompleto" 
                placeholder="Ej: Juan Pérez García" required>
            <div class="invalid-feedback">
                Por favor ingrese el nombre completo
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="email" class="form-label">
                <i class="fas fa-envelope"></i> Email
            </label>
            <input type="email" class="form-control" name="email" id="email" 
                placeholder="ejemplo@correo.com">
            <small class="form-text text-muted">Campo opcional</small>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="rol" class="form-label">
                <i class="fas fa-shield-alt"></i> Rol <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="rol" id="rol" required>
                <option value="">Seleccione un rol...</option>
                <option value="USUARIO">Usuario</option>
                <option value="ADMIN">Administrador</option>
            </select>
            <div class="invalid-feedback">
                Por favor seleccione un rol
            </div>
        </div>
    </div>
    
    <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle"></i> 
        <strong>Nota:</strong> El usuario se creará con estado ACTIVO por defecto.
    </div>
    
    <div class="d-grid gap-2">
        <input type="submit" class="btn btn-primary" value="Guardar">
    </div>
</form>

<script>
(function() {
    'use strict';
    const form = document.getElementById('formUsuario');
    if(form) {
        form.classList.add('was-validated');
    }
})();
</script>