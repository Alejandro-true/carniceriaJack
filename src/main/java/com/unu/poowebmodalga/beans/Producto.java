package com.unu.poowebmodalga.beans;

public class Producto {
	private int idProducto;
	private String nombreProducto;
	private String precioUnitario;
	private int stock;
	private int idCategoria;

	public Producto() {

	}

	
	public Producto(int idProducto, String nombreProducto, String precioUnitario, int stock, int idCategoria) {
		super();
		this.idProducto = idProducto;
		this.nombreProducto = nombreProducto;
		this.precioUnitario = precioUnitario;
		this.stock = stock;
		this.idCategoria = idCategoria;
	}


	public int getIdProducto() {
		return idProducto;
	}

	public void setIdProducto(int idProducto) {
		this.idProducto = idProducto;
	}

	public String getNombreProducto() {
		return nombreProducto;
	}

	public void setNombreProducto(String nombreProducto) {
		this.nombreProducto = nombreProducto;
	}

	public String getPrecioUnitario() {
		return precioUnitario;
	}

	public void setPrecioUnitario(String precioUnitario) {
		this.precioUnitario = precioUnitario;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getIdCategoria() {
		return idCategoria;
	}

	public void setIdCategoria(int idCategoria) {
		this.idCategoria = idCategoria;
	}
	

}
