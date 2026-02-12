<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
String mensaje = (String) session.getAttribute("mensaje");
if(mensaje != null) { 
%>
    <div class="alert alert-info alert-dismissible fade show" role="alert">
        <i class="fas fa-info-circle"></i> <%= mensaje %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<% 
    session.removeAttribute("mensaje");
} 
%>