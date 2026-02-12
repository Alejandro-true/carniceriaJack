package com.unu.poowebmodalga.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.unu.poowebmodalga.beans.Pedido;
import com.unu.poowebmodalga.utilitarios.Conexion;

public class PedidoModel extends Conexion{
	
	CallableStatement cs;
	ResultSet rs;
	
	public List<Pedido> listarPedidos(){
		try {
			List<Pedido> pedidos = new ArrayList<Pedido>();
			String sql = "call sp_listarPedidos()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while(rs.next()) {
				Pedido pedido = new Pedido();
				pedido.setIdPedido(rs.getInt("id_pedido"));
				pedido.setFecha(LocalDate.parse(rs.getString("fecha")));
				pedido.setTotal(rs.getDouble("total"));
				pedido.setIdCliente(rs.getInt("id_cliente"));
				pedidos.add(pedido);
			}
			this.cerrarConexion();
			return pedidos;
		} catch (Exception e) {
			
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
	}
	
	public int insertarPedido(Pedido pedido) {
		try {
			String sql = "call sp_insertarPedido(?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setDouble(1, pedido.getTotal());
			cs.setString(2, pedido.getFecha() +"");
			cs.setInt(3, pedido.getIdCliente());
			this.cerrarConexion();
			return cs.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

}
