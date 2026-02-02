<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Autor"%>
<!DOCTYPE html>
<html>
<head>
<%
String url = request.getContextPath() + "/";
%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<meta charset="UTF-8">
<title>Gestión de Autores</title>
</head>
<body>
<jsp:include page="/components/navbar.jsp" />
	<div class="container mt-4">
		<h2 class="mb-4">
			<i class="fas fa-users"></i> Gestión de Autores
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

		<!-- Botón Nuevo Autor -->
		<button class="btn btn-primary mb-3"
			onclick="modalAutor.abrir('nuevo')">
			<i class="fas fa-plus"></i> Nuevo Autor
		</button>

		<!-- Tabla de Autores -->
		<div class="table-responsive">
			<table class="table table-striped table-hover table-bordered">
				<thead class="table-dark">
					<tr>
						<th><i class="fas fa-hashtag"></i> Código</th>
						<th><i class="fas fa-user"></i> Nombre</th>
						<th><i class="fas fa-flag"></i> Nacionalidad</th>
						<th class="text-center"><i class="fas fa-cog"></i>
							Operaciones</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Autor> listaAutores = (List<Autor>) request.getAttribute("listaAutores");
					if (listaAutores != null && !listaAutores.isEmpty()) {
						for (Autor autor : listaAutores) {
					%>
					<tr>
						<td><code><%=autor.getCodigoAutor()%></code></td>
						<td><%=autor.getNombreAutor()%></td>
						<td><%=autor.getNacionalidad()%></td>
						<td class="text-center">
							<div class="btn-group" role="group">
								<button class="btn btn-warning btn-sm"
									onclick="modalAutor.abrir('editar', <%=autor.getIdAutor()%>)"
									title="Modificar autor">
									<i class="fas fa-edit"></i> Modificar
								</button>
								<button class="btn btn-danger btn-sm"
									onclick="eliminar(<%=autor.getIdAutor()%>)"
									title="Eliminar autor">
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
						<td colspan="4" class="text-center text-muted"><i
							class="fas fa-inbox"></i> No hay autores registrados</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<!-- Modal Universal para Autores -->
	<div class="modal fade" id="modalAutor" tabindex="-1"
		aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-primary text-white">
					<h5 class="modal-title" id="modalAutorLabel">
						<i class="fas fa-user-edit"></i> Autor
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
const modalAutor = {
    instance: null,
    procesando: false,
    
    // Inicializar el modal
    init() {
        const modalElement = document.getElementById('modalAutor');
        this.instance = new bootstrap.Modal(modalElement);        
    },
    
    // Abrir modal (nuevo o editar)
    abrir(tipo, id = null) {
                
        this.resetear();
        const titulo = tipo === 'nuevo' ? 'Nuevo Autor' : 'Editar Autor';
        document.getElementById('modalAutorLabel').textContent = titulo;
        
        this.mostrarSpinner();
        this.instance.show();
        
        // Construir URL
        let fetchUrl = '<%=url%>AutoresController?op=' + tipo + '&modal=true';
        if(id) fetchUrl += '&id=' + id;
        
        // Cargar formulario
        fetch(fetchUrl)
            .then(response => {
                
                return response.text();
            })
            .then(html => {
                
                this.cargarContenido(html);
                this.interceptarFormulario();
            })
            .catch(error => {
                
                this.ocultarSpinner();
                this.mostrarMensaje('Error al cargar el formulario: ' + error.message, 'danger');
            });
    },
    
    // Resetear estado del modal
    resetear() {
        this.procesando = false;
        this.ocultarMensaje();
        this.habilitarBotones();
        document.getElementById('contenidoModal').style.display = 'none';
    },
    
    // Mostrar spinner de carga
    mostrarSpinner() {
        document.getElementById('loadingSpinner').style.display = 'block';
    },
    
    // Ocultar spinner de carga
    ocultarSpinner() {
        document.getElementById('loadingSpinner').style.display = 'none';
    },
    
    // Cargar contenido HTML en el modal
    cargarContenido(html) {
        document.getElementById('contenidoModal').innerHTML = html;
        this.ocultarSpinner();
        document.getElementById('contenidoModal').style.display = 'block';
    },
    
    // Interceptar el envío del formulario
    interceptarFormulario() {
        const form = document.querySelector('#contenidoModal form');
        
        if(!form) {
            
            return;
        }
        
        // Evitar agregar múltiples listeners
        if(form.dataset.listenerAdded === 'true') {
            
            return;
        }
        
        form.dataset.listenerAdded = 'true';
        
        
        form.addEventListener('submit', (e) => this.enviarFormulario(e, form));
    },
 // Enviar formulario por AJAX
    // Enviar formulario por AJAX - VERSIÓN FORMDATA MULTIPART
enviarFormulario(e, form) {
    e.preventDefault();
    
    if(this.procesando) {        
        return;
    }
    
    if(!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    this.procesando = true;
    this.deshabilitarBotones();
    
    // ✨ SIMPLIFICADO: Usar FormData directamente (sin conversión)
    const formData = new FormData(form);
    
    // Forzar operación Ajax si no existe
    let operacion = formData.get('op');
    if(!operacion || !operacion.endsWith('Ajax')) {
        formData.set('op', 'insertarAjax');
    }
    formData.set('ajax', 'true');
    
    // Mostrar datos en consola    
    for(let pair of formData.entries()) {
        
    }
    
    const urlBase = '<%=url%>AutoresController';
    
    // ⚡ CLAVE: NO especificar Content-Type, el navegador lo hace automáticamente
    fetch(urlBase, {
        method: 'POST',
        headers: {
            'X-Requested-With': 'XMLHttpRequest'
            // NO poner Content-Type aquí
        },
        body: formData  // ← FormData directo (sin toString)
    })
    .then(response => {
                
        return response.text();
    })
    .then(text => {
                
        if(text.trim().startsWith('<') || text.trim().startsWith('<!')) {
            
            throw new Error('El servidor devolvió HTML en lugar de JSON');
        }
        
        try {
            const data = JSON.parse(text);            
            return data;
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
                location.href = '<%=url%>AutoresController?op=listar';
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
     
    // Deshabilitar botones durante el envío
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
    
    // Habilitar botones después del envío
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
    
    // Mostrar mensaje en el modal
    mostrarMensaje(mensaje, tipo) {
        const mensajeDiv = document.getElementById('mensajeModal');
        mensajeDiv.className = 'alert alert-' + tipo;
        mensajeDiv.textContent = mensaje;
        mensajeDiv.classList.remove('d-none');
    },
    
    // Ocultar mensaje
    ocultarMensaje() {
        const mensajeDiv = document.getElementById('mensajeModal');
        mensajeDiv.classList.add('d-none');
    }
};

// ====================================
// FUNCIÓN PARA ELIMINAR
// ====================================
function eliminar(id) {
    if (confirm('¿Está seguro de eliminar este autor?')) {        
        window.location.href = '<%=url%>AutoresController?op=eliminar&id=' + id;
    }
}

// ====================================
// INICIALIZAR AL CARGAR LA PÁGINA
// ====================================
document.addEventListener('DOMContentLoaded', function() {    
    modalAutor.init();
});
</script>

</body>
</html>