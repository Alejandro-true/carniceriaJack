package com.unu.poowebmodalga.dto;

public class LibroGenero {
	private String nombreGenero;
	private int total;
	
	public LibroGenero() {
		super();
	}

	public LibroGenero(String nombreGenero, int total) {
		super();
		this.nombreGenero = nombreGenero;
		this.total = total;
	}
	
	public String getNombreGenero() {
		return nombreGenero;
	}
	public void setNombreGenero(String nombreGenero) {
		this.nombreGenero = nombreGenero;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
}
