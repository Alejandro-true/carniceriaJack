<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Modal Universal para Autores -->
<div class="modal fade" id="modalAutor" tabindex="-1" aria-hidden="true" 
    data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="modalAutorLabel">
                    <i class="fas fa-user-edit"></i> Autor
                </h5>
                <button type="button" class="btn-close btn-close-white" 
                    data-bs-dismiss="modal" id="btnCerrarModal">
                </button>
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