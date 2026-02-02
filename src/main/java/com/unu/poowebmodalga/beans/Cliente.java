package com.unu.poowebmodalga.beans;

public class Cliente {

	private int idCliente;
	private String nombreCompleto;
	private String telefono;
	private String direccion;
	private String email;
	private String dni;

	public enum Estado {
		ACTIVO, INACTIVO
	};

	private Estado estado;

	public Cliente() {
		super();
	}

	public Cliente(int idCliente, String nombreCompleto, String telefono, String direccion, String email, String dni,
			Estado estado) {
		super();
		this.idCliente = idCliente;
		this.nombreCompleto = nombreCompleto;
		this.telefono = telefono;
		this.direccion = direccion;
		this.email = email;
		this.dni = dni;
		this.estado = estado;
	}

	// Getters y Setters
	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public String getNombreCompleto() {
		return nombreCompleto;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public Estado getEstado() {
		return estado;
	}

	public void setEstado(Estado estado) {
		this.estado = estado;
	}

}