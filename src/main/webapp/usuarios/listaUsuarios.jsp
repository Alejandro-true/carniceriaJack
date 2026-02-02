<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Usuario"%>
<!DOCTYPE html>
<html>
<head>
<%
String url = request.getContextPath() + "/";
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
    crossorigin="anonymous">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<meta charset="UTF-8">
<title>Gestión de Usuarios</title>
</head>
<body>

<!-- Navbar -->
<jsp:include page="/components/navbar.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">
        <i class="fas fa-user-shield"></i> Gestión de Usuarios
    </h2>

    <!-- Mensajes de sesión -->
    <%
    String mensaje = (String) session.getAttribute("mensaje");
    if (mensaje != null) {
    %>
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <i class="fas fa-info-circle"></i>
        <%=mensaje%>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <%
    session.removeAttribute("mensaje");
    }
    %>

    <!-- Botón Nuevo Usuario -->
    <button class="btn btn-primary mb-3" onclick="modalUsuario.abrir('nuevo')">
        <i class="fas fa-plus"></i> Nuevo Usuario
    </button>

    <!-- Tabla de Usuarios -->
    <div class="table-responsive">
        <table class="table table-striped table-hover table-bordered">
            <thead class="table-dark">
                <tr>
                    <th><i class="fas fa-hashtag"></i> ID</th>
                    <th><i class="fas fa-user"></i> Usuario</th>
                    <th><i class="fas fa-id-card"></i> Nombre Completo</th>
                    <th><i class="fas fa-envelope"></i> Email</th>
                    <th><i class="fas fa-shield-alt"></i> Rol</th>
                    <th><i class="fas fa-toggle-on"></i> Estado</th>
                    <th class="text-center"><i class="fas fa-cog"></i> Operaciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<Usuario> listaUsuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
                if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                    for (Usuario usuario : listaUsuarios) {
                        String badgeEstado = "ACTIVO".equals(usuario.getEstado()) ? "bg-success" : "bg-danger";
                        String badgeRol = "ADMIN".equals(usuario.getRol()) ? "bg-warning text-dark" : "bg-secondary";
                %>
                <tr>
                    <td><code><%=usuario.getIdUsuario()%></code></td>
                    <td><strong><%=usuario.getNombreUsuario()%></strong></td>
                    <td><%=usuario.getNombreCompleto()%></td>
                    <td><%=usuario.getEmail() != null ? usuario.getEmail() : "-"%></td>
                    <td>
                        <span class="badge <%=badgeRol%>">
                            <%=usuario.getRol()%>
                        </span>
                    </td>
                    <td>
                        <span class="badge <%=badgeEstado%>">
                            <%=usuario.getEstado()%>
                        </span>
                    </td>
                    <td class="text-center">
                        <div class="btn-group" role="group">
                            <button class="btn btn-warning btn-sm"
                                onclick="modalUsuario.abrir('editar', <%=usuario.getIdUsuario()%>)"
                                title="Modificar usuario">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-info btn-sm"
                                onclick="modalUsuario.abrir('cambiarPassword', <%=usuario.getIdUsuario()%>)"
                                title="Cambiar contraseña">
                                <i class="fas fa-key"></i>
                            </button>
                            <button class="btn btn-danger btn-sm"
                                onclick="eliminar(<%=usuario.getIdUsuario()%>)"
                                title="Eliminar usuario">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
                <%
                }
                } else {
                %>
                <tr>
                    <td colspan="7" class="text-center text-muted">
                        <i class="fas fa-inbox"></i> No hay usuarios registrados
                    </td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Universal para Usuarios -->
<div class="modal fade" id="modalUsuario" tabindex="-1"
    aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="modalUsuarioLabel">
                    <i class="fas fa-user-edit"></i> Usuario
                </h5>
                <button type="button" class="btn-close btn-close-white"
                    data-bs-dismiss="modal" id="btnCerrarModal"></button>
            </div>
            <div class="modal-body">
                <div id="loadingSpinner" class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Cargando...</span>
                    </div>
                    <p class="mt-2 text-muted">Cargando formulario...</p>
                </div>

                <div id="mensajeModal" class="alert d-none" role="alert"></div>
                <div id="contenidoModal" style="display: none;"></div>
            </div>
        </div>
    </div>
</div>

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"></script>

<script>
const modalUsuario = {
    instance: null,
    procesando: false,
    
    init() {
        const modalElement = document.getElementById('modalUsuario');
        this.instance = new bootstrap.Modal(modalElement);        
    },
    
    abrir(tipo, id = null) {
        this.resetear();
        let titulo = 'Usuario';
        if(tipo === 'nuevo') titulo = 'Nuevo Usuario';
        else if(tipo === 'editar') titulo = 'Editar Usuario';
        else if(tipo === 'cambiarPassword') titulo = 'Cambiar Contraseña';
        
        document.getElementById('modalUsuarioLabel').innerHTML = '<i class="fas fa-user-edit"></i> ' + titulo;
        
        this.mostrarSpinner();
        this.instance.show();
        
        let fetchUrl = '<%=url%>UsuariosController?op=' + tipo + '&modal=true';
        if(id) fetchUrl += '&id=' + id;
        
        fetch(fetchUrl)
            .then(response => response.text())
            .then(html => {
                this.cargarContenido(html);
                this.interceptarFormulario();
            })
            .catch(error => {
                this.ocultarSpinner();
                this.mostrarMensaje('Error al cargar el formulario: ' + error.message, 'danger');
            });
    },
    
    resetear() {
        this.procesando = false;
        this.ocultarMensaje();
        this.habilitarBotones();
        document.getElementById('contenidoModal').style.display = 'none';
    },
    
    mostrarSpinner() {
        document.getElementById('loadingSpinner').style.display = 'block';
    },
    
    ocultarSpinner() {
        document.getElementById('loadingSpinner').style.display = 'none';
    },
    
    cargarContenido(html) {
        document.getElementById('contenidoModal').innerHTML = html;
        this.ocultarSpinner();
        document.getElementById('contenidoModal').style.display = 'block';
    },
    
    interceptarFormulario() {
        const form = document.querySelector('#contenidoModal form');
        if(!form || form.dataset.listenerAdded === 'true') return;
        
        form.dataset.listenerAdded = 'true';
        form.addEventListener('submit', (e) => this.enviarFormulario(e, form));
    },
    
    enviarFormulario(e, form) {
        e.preventDefault();
        
        if(this.procesando) return;
        
        if(!form.checkValidity()) {
            form.reportValidity();
            return;
        }
        
        this.procesando = true;
        this.deshabilitarBotones();
        
        const formData = new FormData(form);
        
        let operacion = formData.get('op');
        if(!operacion || !operacion.endsWith('Ajax')) {
            formData.set('op', operacion + 'Ajax');
        }
        
        const urlBase = '<%=url%>UsuariosController';
        
        fetch(urlBase, {
            method: 'POST',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: formData
        })
        .then(response => response.text())
        .then(text => {
            if(text.trim().startsWith('<')) {
                throw new Error('El servidor devolvió HTML en lugar de JSON');
            }
            return JSON.parse(text);
        })
        .then(data => {
            this.procesando = false;
            
            if(data.success) {
                this.mostrarMensaje(data.mensaje, 'success');
                setTimeout(() => {
                    this.instance.hide();
                    location.href = '<%=url%>UsuariosController?op=listar';
                }, 1500);
            } else {
                this.mostrarMensaje(data.mensaje, 'danger');
                this.habilitarBotones();
            }
        })
        .catch(error => {
            this.procesando = false;
            this.mostrarMensaje('Error: ' + error.message, 'danger');
            this.habilitarBotones();
        });
    },
    
    deshabilitarBotones() {
        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"], #contenidoModal button[type="submit"]');
        const btnCerrar = document.getElementById('btnCerrarModal');
        
        if(btnGuardar) {
            btnGuardar.disabled = true;
            if(btnGuardar.tagName === 'BUTTON') {
                btnGuardar.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';
            } else {
                btnGuardar.value = 'Guardando...';
            }
        }
        if(btnCerrar) btnCerrar.disabled = true;
    },
    
    habilitarBotones() {
        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"], #contenidoModal button[type="submit"]');
        const btnCerrar = document.getElementById('btnCerrarModal');
        
        if(btnGuardar) {
            btnGuardar.disabled = false;
            if(btnGuardar.tagName === 'BUTTON') {
                btnGuardar.innerHTML = '<i class="fas fa-save"></i> Guardar';
            } else {
                btnGuardar.value = 'Guardar';
            }
        }
        if(btnCerrar) btnCerrar.disabled = false;
    },
    
    mostrarMensaje(mensaje, tipo) {
        const mensajeDiv = document.getElementById('mensajeModal');
        mensajeDiv.className = 'alert alert-' + tipo;
        mensajeDiv.textContent = mensaje;
        mensajeDiv.classList.remove('d-none');
    },
    
    ocultarMensaje() {
        document.getElementById('mensajeModal').classList.add('d-none');
    }
};

function eliminar(id) {
    if (confirm('¿Está seguro de eliminar este usuario? Esta acción no se puede deshacer.')) {
        window.location.href = '<%=url%>UsuariosController?op=eliminar&id=' + id;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    modalUsuario.init();
});
</script>

</body>
</html>