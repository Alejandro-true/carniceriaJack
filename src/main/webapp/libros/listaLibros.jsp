<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Libro"%>
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
<title>Gestión de Libros</title>
</head>
<body>
<jsp:include page="/components/navbar.jsp" />
    <div class="container mt-4">
        <h2 class="mb-4">
            <i class="fas fa-book"></i> Gestión de Libros
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

        <!-- Botón Nuevo Libro -->
        <button class="btn btn-primary mb-3" onclick="modalLibro.abrir('nuevo')">
            <i class="fas fa-plus"></i> Nuevo Libro
        </button>

        <!-- Tabla de Libros -->
        <div class="table-responsive">
            <table class="table table-striped table-hover table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th><i class="fas fa-hashtag"></i> ID</th>
                        <th><i class="fas fa-book"></i> Título</th>
                        <th><i class="fas fa-user"></i> Autor</th>
                        <th><i class="fas fa-tag"></i> Género</th>
                        <th><i class="fas fa-boxes"></i> Existencia</th>
                        <th><i class="fas fa-dollar-sign"></i> Precio</th>
                        <th class="text-center"><i class="fas fa-cog"></i> Operaciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    List<Libro> listaLibros = (List<Libro>) request.getAttribute("listaLibros");
                    if (listaLibros != null && !listaLibros.isEmpty()) {
                        for (Libro libro : listaLibros) {
                    %>
                    <tr>
                        <td><code><%=libro.getIdLibro()%></code></td>
                        <td><%=libro.getNombreLibro()%></td>
                        <td><%=libro.getNombreAutor()%></td>
                        <td><%=libro.getNombreGenero()%></td>
                        <td class="text-center">
                            <span class="badge bg-info"><%=libro.getExistencia()%></span>
                        </td>
                        <td class="text-end">$<%=String.format("%.2f", libro.getPrecio())%></td>
                        <td class="text-center">
                            <div class="btn-group" role="group">
                                <button class="btn btn-warning btn-sm"
                                    onclick="modalLibro.abrir('editar', <%=libro.getIdLibro()%>)"
                                    title="Modificar libro">
                                    <i class="fas fa-edit"></i> Modificar
                                </button>
                                <button class="btn btn-danger btn-sm"
                                    onclick="eliminar(<%=libro.getIdLibro()%>)"
                                    title="Eliminar libro">
                                    <i class="fas fa-trash"></i> Eliminar
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
                            <i class="fas fa-inbox"></i> No hay libros registrados
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Universal para Libros -->
    <div class="modal fade" id="modalLibro" tabindex="-1"
        aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="modalLibroLabel">
                        <i class="fas fa-book-open"></i> Libro
                    </h5>
                    <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal" id="btnCerrarModal"></button>
                </div>
                <div class="modal-body">
                    <!-- Spinner de carga -->
                    <div id="loadingSpinner" class="text-center py-4">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Cargando...</span>
                        </div>
                        <p class="mt-2 text-muted">Cargando formulario...</p>
                    </div>

                    <!-- Área de mensajes -->
                    <div id="mensajeModal" class="alert d-none" role="alert"></div>

                    <!-- Contenido dinámico del formulario -->
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
// ====================================
// OBJETO GLOBAL PARA MANEJAR EL MODAL
// ====================================
const modalLibro = {
    instance: null,
    procesando: false,
    
    init() {
        const modalElement = document.getElementById('modalLibro');
        this.instance = new bootstrap.Modal(modalElement);        
    },
    
    abrir(tipo, id = null) {
        this.resetear();
        const titulo = tipo === 'nuevo' ? 'Nuevo Libro' : 'Editar Libro';
        document.getElementById('modalLibroLabel').textContent = titulo;
        
        this.mostrarSpinner();
        this.instance.show();
        
        let fetchUrl = '<%=url%>LibrosController?op=' + tipo + '&modal=true';
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
            formData.set('op', 'insertarAjax');
        }
        formData.set('ajax', 'true');
        
        const urlBase = '<%=url%>LibrosController';
        
        fetch(urlBase, {
            method: 'POST',
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: formData
        })
        .then(response => response.text())
        .then(text => {
            if(text.trim().startsWith('<') || text.trim().startsWith('<!')) {
                throw new Error('El servidor devolvió HTML en lugar de JSON');
            }
            
            try {
                return JSON.parse(text);
            } catch (e) {
                throw new Error('Respuesta no es JSON válido: ' + e.message);
            }
        })
        .then(data => {
            this.procesando = false;
            
            if(data.success) {
                this.mostrarMensaje(data.mensaje, 'success');
                setTimeout(() => {
                    this.instance.hide();
                    location.href = '<%=url%>LibrosController?op=listar';
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
        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"]');
        const btnCerrar = document.getElementById('btnCerrarModal');
        
        if(btnGuardar) {
            btnGuardar.disabled = true;
            btnGuardar.value = 'Guardando...';
        }
        if(btnCerrar) {
            btnCerrar.disabled = true;
        }
    },
    
    habilitarBotones() {
        const btnGuardar = document.querySelector('#contenidoModal input[type="submit"]');
        const btnCerrar = document.getElementById('btnCerrarModal');
        
        if(btnGuardar) {
            btnGuardar.disabled = false;
            btnGuardar.value = 'Guardar';
        }
        if(btnCerrar) {
            btnCerrar.disabled = false;
        }
    },
    
    mostrarMensaje(mensaje, tipo) {
        const mensajeDiv = document.getElementById('mensajeModal');
        mensajeDiv.className = 'alert alert-' + tipo;
        mensajeDiv.textContent = mensaje;
        mensajeDiv.classList.remove('d-none');
    },
    
    ocultarMensaje() {
        const mensajeDiv = document.getElementById('mensajeModal');
        mensajeDiv.classList.add('d-none');
    }
};

function eliminar(id) {
    if (confirm('¿Está seguro de eliminar este libro?')) {
        window.location.href = '<%=url%>LibrosController?op=eliminar&id=' + id;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    modalLibro.init();
});
</script>

</body>
</html>