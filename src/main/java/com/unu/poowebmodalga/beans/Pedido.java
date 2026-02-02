package com.unu.poowebmodalga.beans;

import java.time.LocalDate;

public class Pedido {

	private int idPedido;
	private LocalDate fecha;
	private double total;
	private int idCliente;

	public Pedido() {
		super();
	}

	public Pedido(int idPedido, LocalDate fecha, double total, int idCliente) {
		super();
		this.idPedido = idPedido;
		this.fecha = fecha;
		this.total = total;
		this.idCliente = idCliente;
	}

	public int getIdPedido() {
		return idPedido;
	}

	public void setIdPedido(int idPedido) {
		this.idPedido = idPedido;
	}

	public LocalDate getFecha() {
		return fecha;
	}

	public void setFecha(LocalDate fecha) {
		this.fecha = fecha;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

}
