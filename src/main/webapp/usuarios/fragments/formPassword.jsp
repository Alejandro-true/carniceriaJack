<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.beans.Usuario"%>

<%
String url = request.getContextPath() + "/";
Usuario usuario = (Usuario) request.getAttribute("usuario");
if (usuario == null) {
    usuario = new Usuario();
}
%>

<form action="<%=url%>UsuariosController" method="POST" id="formPassword" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="cambiarPasswordAjax">
    <input type="hidden" name="id" value="<%=usuario.getIdUsuario()%>">

    <div class="alert alert-info" role="alert">
        <i class="fas fa-user"></i>
        Cambiar contraseña de:
        <strong><%=usuario.getNombreCompleto()%></strong>
        (<%=usuario.getNombreUsuario()%>)
    </div>

    <!-- Nueva contraseña -->
    <div class="mb-3">
        <label for="passwordNueva" class="form-label">
            <i class="fas fa-lock"></i> Nueva Contraseña <span class="text-danger">*</span>
        </label>
        <div class="input-group">
            <input type="password" class="form-control" name="passwordNueva" id="passwordNueva"
                   placeholder="Ingrese la nueva contraseña" required minlength="6">
            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                <i class="fas fa-eye"></i>
            </button>
        </div>
        <div class="invalid-feedback">
            La contraseña debe tener al menos 6 caracteres
        </div>
    </div>

    <!-- Confirmar contraseña -->
    <div class="mb-3">
        <label for="passwordConfirmar" class="form-label">
            <i class="fas fa-lock"></i> Confirmar Contraseña <span class="text-danger">*</span>
        </label>
        <input type="password" class="form-control" name="passwordConfirmar" id="passwordConfirmar"
               placeholder="Confirme la nueva contraseña" required minlength="6">
        <div class="invalid-feedback">
            Debe confirmar la contraseña
        </div>
    </div>

    <div class="alert alert-warning" role="alert">
        <i class="fas fa-exclamation-triangle"></i>
        <strong>Importante:</strong> La contraseña será encriptada usando MD5.
    </div>

    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-info">
            <i class="fas fa-key"></i> Cambiar Contraseña
        </button>
    </div>
</form>

<script>
(function () {
    'use strict';

    const form = document.getElementById('formPassword');
    const passwordNueva = document.getElementById('passwordNueva');
    const passwordConfirmar = document.getElementById('passwordConfirmar');
    const togglePassword = document.getElementById('togglePassword');

    // Validación Bootstrap + contraseñas iguales
    form.addEventListener('submit', function (e) {
        if (!form.checkValidity() || passwordNueva.value !== passwordConfirmar.value) {
            e.preventDefault();
            e.stopPropagation();

            if (passwordNueva.value !== passwordConfirmar.value) {
                alert('Las contraseñas no coinciden');
            }
        }
        form.classList.add('was-validated');
    });

    // Mostrar / ocultar contraseña
    togglePassword.addEventListener('click', function () {
        const icon = this.querySelector('i');

        if (passwordNueva.type === 'password') {
            passwordNueva.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
        } else {
            passwordNueva.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
        }
    });
})();
</script>
