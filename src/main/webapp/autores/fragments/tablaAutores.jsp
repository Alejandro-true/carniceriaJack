<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Autor"%>

<div class="table-responsive">
    <table class="table table-striped table-hover table-bordered">
        <thead class="table-dark">
            <tr>
                <th><i class="fas fa-hashtag"></i> Código</th>
                <th><i class="fas fa-user"></i> Nombre</th>
                <th><i class="fas fa-flag"></i> Nacionalidad</th>
                <th class="text-center"><i class="fas fa-cog"></i> Operaciones</th>
            </tr>
        </thead>
        <tbody>
            <% 
            List<Autor> listaAutores = (List<Autor>) request.getAttribute("listaAutores");
            if(listaAutores != null && !listaAutores.isEmpty()) {
                for(Autor autor : listaAutores) {
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
                            onclick="eliminar('<%=autor.getIdAutor()%>')"
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
                <td colspan="4" class="text-center text-muted">
                    <i class="fas fa-inbox"></i> No hay autores registrados
                </td>
            </tr>
            <%
            }
            %>
        </tbody>
    </table>
</div>