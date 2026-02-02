<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.beans.Usuario"%>
<% 
String url = request.getContextPath() + "/";
Usuario usuario = (Usuario) request.getAttribute("usuario");
if(usuario == null) {
    usuario = new Usuario();
}
%>

<form action="<%=url%>UsuariosController" method="POST" id="formUsuario" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=usuario.getIdUsuario()%>">
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="nombreUsuario" class="form-label">
                <i class="fas fa-user"></i> Nombre de Usuario <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreUsuario" id="nombreUsuario" 
                value="<%=usuario.getNombreUsuario() != null ? usuario.getNombreUsuario() : ""%>" 
                placeholder="Ej: jperez" required pattern="[a-zA-Z0-9_]{4,20}"
                title="4-20 caracteres, solo letras, números y guión bajo">
            <div class="invalid-feedback">
                Usuario debe tener 4-20 caracteres (letras, números, _)
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="nombreCompleto" class="form-label">
                <i class="fas fa-id-card"></i> Nombre Completo <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombreCompleto" id="nombreCompleto" 
                value="<%=usuario.getNombreCompleto() != null ? usuario.getNombreCompleto() : ""%>" 
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
                value="<%=usuario.getEmail() != null ? usuario.getEmail() : ""%>" 
                placeholder="ejemplo@correo.com">
            <small class="form-text text-muted">Campo opcional</small>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="rol" class="form-label">
                <i class="fas fa-shield-alt"></i> Rol <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="rol" id="rol" required>
                <option value="">Seleccione un rol...</option>
                <option value="USUARIO" <%= "USUARIO".equals(usuario.getRol()) ? "selected" : "" %>>
                    Usuario
                </option>
                <option value="ADMIN" <%= "ADMIN".equals(usuario.getRol()) ? "selected" : "" %>>
                    Administrador
                </option>
            </select>
            <div class="invalid-feedback">
                Por favor seleccione un rol
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <label for="estado" class="form-label">
                <i class="fas fa-toggle-on"></i> Estado <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="estado" id="estado" required>
                <option value="">Seleccione un estado...</option>
                <option value="ACTIVO" <%= "ACTIVO".equals(usuario.getEstado()) ? "selected" : "" %>>
                    Activo
                </option>
                <option value="INACTIVO" <%= "INACTIVO".equals(usuario.getEstado()) ? "selected" : "" %>>
                    Inactivo
                </option>
            </select>
            <div class="invalid-feedback">
                Por favor seleccione un estado
            </div>
        </div>
    </div>
    
    <div class="alert alert-warning" role="alert">
        <i class="fas fa-exclamation-triangle"></i> 
        Modificando usuario ID: <strong><%=usuario.getIdUsuario()%></strong><br>
        <small>Para cambiar la contraseña, use el botón "Cambiar Contraseña"</small>
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-warning">
            <i class="fas fa-save"></i> Actualizar Usuario
        </button>
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