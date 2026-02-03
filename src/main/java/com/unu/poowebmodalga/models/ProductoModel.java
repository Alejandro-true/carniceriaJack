package com.unu.poowebmodalga.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.unu.poowebmodalga.beans.Producto;
import com.unu.poowebmodalga.dto.AutorPaisDTO;
import com.unu.poowebmodalga.utilitarios.Conexion;

public class ProductoModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;

	public List<Producto> listarProducto() {

		try {
			ArrayList<Producto> productos = new ArrayList<>();
			String sql = "CALL sp_listarProducto()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				Producto producto = new Producto();
				producto.setIdProducto(rs.getInt("id_producto"));
				producto.setNombreProducto(rs.getString("nombre"));
				producto.setPrecioUnitario(rs.getDouble("precio"));
				producto.setStock(rs.getInt("stock"));
				producto.setIdCategoria(rs.getInt("id_categoria"));
				productos.add(producto);
			}

			this.cerrarConexion();
			return productos;
		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}

	}

	public int insertarCategoria(Producto producto) {
		try {

			int filasAfectadas = 0;
			String sql = "CALL sp_insertarProducto(?,?,?)";

			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, producto.getNombreProducto());
			cs.setDouble(2, producto.getPrecioUnitario());
			cs.setInt(3, producto.getStock());
			cs.setInt(4, producto.getIdCategoria());
			filasAfectadas = cs.executeUpdate();
			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0; // Cambiar de -1 a 0 para consistencia
		}
	}

	public Producto obtenerProducto(int idProducto) {
		Producto producto = new Producto();
		try {
			String sql = "CALL sp_obtenerAutor(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idProducto);
			rs = cs.executeQuery();
			if (rs.next()) {
				producto.setIdProducto(rs.getInt("id_producto"));
				producto.setNombreProducto(rs.getString("nombre"));
				producto.setPrecioUnitario(rs.getDouble("precio"));
				producto.setStock(rs.getInt("stock"));
				producto.setIdCategoria(rs.getInt("id_categoria"));
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
		return producto;
	}

	public int modificarAutor(Producto producto) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_modificarProducto(?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, producto.getNombreProducto());
			cs.setDouble(2, producto.getPrecioUnitario());
			cs.setInt(3, producto.getStock());
			cs.setInt(4, producto.getIdCategoria());
			filasAfectadas = cs.executeUpdate();

			// IMPORTANTE: Cerrar la conexión antes de retornar
			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

	public int eliminarAutor(int idautor) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_eliminarAutor(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idautor);
			filasAfectadas = cs.executeUpdate();

			// IMPORTANTE: Cerrar la conexión antes de retornar
			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

	public List<AutorPaisDTO> obtenerAutoresPorPais() {

		try {
			ArrayList<AutorPaisDTO> autores = new ArrayList<>();
			String sql = "CALL sp_ObtenerAutoresPais()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				autores.add(new AutorPaisDTO(rs.getString("pais"), rs.getInt("total")));
			}
			this.cerrarConexion();
			return autores;
		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}

	}

}