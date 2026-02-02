package com.unu.poowebmodalga.beans;

public class Autor {

public Autor() {
	
}
public Autor(String codigoAutor, String nacionalidad, String nombreAutor) {
		super();
		this.codigoAutor = codigoAutor;
		this.nacionalidad = nacionalidad;
		this.nombreAutor = nombreAutor;
	}

private int idAutor;
private String codigoAutor;
private String nacionalidad;
private String nombreAutor;


public int getIdAutor() {
	return idAutor;
}
public void setIdAutor(int idAutor) {
	this.idAutor = idAutor;
}
public String getNombreAutor() {
	return nombreAutor;
}
public void setNombreAutor(String nombreAutor) {
	this.nombreAutor = nombreAutor;
}
public String getNacionalidad() {
	return nacionalidad;
}
public void setNacionalidad(String nacionalidad) {
	this.nacionalidad = nacionalidad;
}
public String getCodigoAutor() {
	return codigoAutor;
}
public void setCodigoAutor(String codigoAutor) {
	this.codigoAutor = codigoAutor;
}



}
