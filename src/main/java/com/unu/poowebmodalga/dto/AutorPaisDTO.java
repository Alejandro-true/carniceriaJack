package com.unu.poowebmodalga.dto;

public class AutorPaisDTO {
	private String pais;
	private int total;

	public AutorPaisDTO(String pais, int total) {
		this.pais = pais;
		this.total = total;
	}

	public String getPais() {
		return pais;
	}

	public int getTotal() {
		return total;
	}
}
