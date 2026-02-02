<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Autor"%>
<%@ page import="com.unu.poowebmodalga.beans.Genero"%>
<%
String url = request.getContextPath() + "/";
List<Autor> listaAutores = (List<Autor>) request.getAttribute("listaAutores");
List<Genero> listaGeneros = (List<Genero>) request.getAttribute("listaGeneros");
%>

<form action="<%=url%>LibrosController" method="POST" id="formLibro" class="needs-validation" novalidate>
    <input type="hidden" name="op" value="insertarAjax">
    
    <div class="row">
        <div class="col-md-12 mb-3">
            <label for="nombre" class="form-label">
                <i class="fas fa-book"></i> Título del Libro <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" name="nombre" id="nombre" 
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
                %>
                <option value="<%=autor.getIdAutor()%>"><%=autor.getNombreAutor()%></option>
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
                %>
                <option value="<%=genero.getIdGenero()%>">
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
            rows="3" placeholder="Breve descripción del libro..." required></textarea>
        <div class="invalid-feedback">
            Por favor ingrese una descripción
        </div>
    </div>
    
    <div class="d-grid gap-2">
        <input type="submit" class="btn btn-primary" value="Guardar">
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