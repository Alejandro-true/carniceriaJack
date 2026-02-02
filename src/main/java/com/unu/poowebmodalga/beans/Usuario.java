package com.unu.poowebmodalga.beans;

import java.sql.Timestamp;

public class Usuario {
    
    private int idUsuario;
    private String nombreUsuario;
    private String contrasena;
    private String nombreCompleto;
    private String email;
    private String rol;
    private String estado;
    private Timestamp fechaCreacion;
    
    public Usuario() {
    }
    
    public Usuario(String nombreUsuario, String password, String nombreCompleto, String email, String rol) {
        this.nombreUsuario = nombreUsuario;
        this.contrasena = password;
        this.nombreCompleto = nombreCompleto;
        this.email = email;
        this.rol = rol;
    }

    // Getters y Setters
    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }


    public String getContrasena() {
		return contrasena;
	}

	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}

	public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    // Método de utilidad
    public boolean esAdmin() {
        return "ADMIN".equals(this.rol);
    }
    
    public boolean estaActivo() {
        return "ACTIVO".equals(this.estado);
    }
}