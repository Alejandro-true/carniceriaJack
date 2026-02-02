<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Libro"%>
<%@ page import="com.unu.poowebmodalga.beans.Autor"%>
<%@ page import="com.unu.poowebmodalga.beans.Genero"%>
<% 
String url = request.getContextPath() + "/";
Libro libro = (Libro) request.getAttribute("libro");
List<Autor> listaAutores = (List<Autor>) request.getAttribute("listaAutores");
List<Genero> listaGeneros = (List<Genero>) request.getAttribute("listaGeneros");

if(libro == null) {
    libro = new Libro();
}
%>

<form action="<%=url%>LibrosController" method="POST" id="formLibro" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="modificarAjax">
    <input type="hidden" name="id" value="<%=libro.getIdLibro()%>">
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="nombre" class="form-label">
                <i class="fas fa-book"></i> Título del Libro <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombre" id="nombre" 
                value="<%=libro.getNombreLibro() != null ? libro.getNombreLibro() : ""%>" 
                placeholder="Ej: Cien años de soledad" required>
            <div class="invalid-feedback">
                Por favor ingrese el título del libro
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="autor" class="form-label">
                <i class="fas fa-user"></i> Autor <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="autor" id="autor" required>
                <option value="">Seleccione un autor...</option>
                <%
                if (listaAutores != null && !listaAutores.isEmpty()) {
                    for (Autor autor : listaAutores) {
                        String selected = (libro.getIdAutor() == autor.getIdAutor()) ? "selected" : "";
                %>
                <option value="<%=autor.getIdAutor()%>" <%=selected%>>
                    <%=autor.getNombreAutor()%>
                </option>
                <%
                    }
                } else {
                %>
                <option value="" disabled>No hay autores disponibles</option>
                <%
                }
                %>
            </select>
            <div class="invalid-feedback">
                Por favor seleccione un autor
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <label for="genero" class="form-label">
                <i class="fas fa-tag"></i> Género <span class="text-danger">*</span>
            </label>
            <select class="form-select" name="genero" id="genero" required>
                <option value="">Seleccione un género...</option>
                <%
                if (listaGeneros != null && !listaGeneros.isEmpty()) {
                    for (Genero genero : listaGeneros) {
                        String selected = (libro.getIdGenero() == genero.getIdGenero()) ? "selected" : "";
                %>
                <option value="<%=genero.getIdGenero()%>" <%=selected%>>
                    <%=genero.getNombreGenero()%> (<%=genero.getAbreviatura()%>)
                </option>
                <%
                    }
                } else {
                %>
                <option value="" disabled>No hay géneros disponibles</option>
                <%
                }
                %>
            </select>
            <div class="invalid-feedback">
                Por favor seleccione un género
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="existencia" class="form-label">
                <i class="fas fa-boxes"></i> Existencia <span class="text-danger">*</span>
            </label>
            <input type="number" class="form-control" name="existencia" id="existencia" 
                value="<%=libro.getExistencia()%>" 
                placeholder="Ej: 10" min="0" required>
            <div class="invalid-feedback">
                Por favor ingrese la existencia
            </div>
        </div>
        
        <div class="col-md-6 mb-3">
            <label for="precio" class="form-label">
                <i class="fas fa-dollar-sign"></i> Precio <span class="text-danger">*</span>
            </label>
            <input type="number" class="form-control" name="precio" id="precio" 
                value="<%=libro.getPrecio()%>" 
                placeholder="Ej: 25.50" step="0.01" min="0" required>
            <div class="invalid-feedback">
                Por favor ingrese el precio
            </div>
        </div>
    </div>
    
    <div class="mb-3">
        <label for="descripcion" class="form-label">
            <i class="fas fa-align-left"></i> Descripción <span class="text-danger">*</span>
        </label>
        <textarea class="form-control" name="descripcion" id="descripcion" 
            rows="3" placeholder="Breve descripción del libro..." required><%=libro.getDescripcion() != null ? libro.getDescripcion() : ""%></textarea>
        <div class="invalid-feedback">
            Por favor ingrese una descripción
        </div>
    </div>
    
    <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle"></i> 
        Modificando libro ID: <strong><%=libro.getIdLibro()%></strong>
    </div>
    
    <div class="d-grid gap-2">
        <button type="submit" class="btn btn-warning">
            <i class="fas fa-save"></i> Actualizar Libro
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    const form = document.getElementById('formLibro');
    if(form) {
        form.classList.add('was-validated');
    }
})();
</script>