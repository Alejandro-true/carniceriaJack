package com.unu.poowebmodalga.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.unu.poowebmodalga.beans.Producto;
import com.unu.poowebmodalga.dto.AutorPaisDTO;
import com.unu.poowebmodalga.utilitarios.Conexion;

public class AutoresModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;

	public List<Producto> listarAutores() {

		try {
			ArrayList<Producto> autores = new ArrayList<>();
			String sql = "CALL sp_listarAutores()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				Producto autor = new Producto();
				autor.setIdAutor(rs.getInt("idautores"));
				autor.setCodigoAutor(rs.getString("codigoAutor"));
				autor.setNacionalidad(rs.getString("nacionalidad"));
				autor.setNombreAutor(rs.getString("nombreAutor"));
				autores.add(autor);
			}

			this.cerrarConexion();
			return autores;
		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}

	}

	public int insertarAutor(Producto autor) {
		try {

			int filasAfectadas = 0;
			String sql = "CALL sp_insertarAutor(?,?,?)";

			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, autor.getCodigoAutor());
			cs.setString(2, autor.getNacionalidad());
			cs.setString(3, autor.getNombreAutor());
			filasAfectadas = cs.executeUpdate();
			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0; // Cambiar de -1 a 0 para consistencia
		}
	}

	public Producto obtenerAutor(int idautor) {
		Producto autor = new Producto();
		try {
			String sql = "CALL sp_obtenerAutor(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idautor);
			rs = cs.executeQuery();
			if (rs.next()) {
				autor.setIdAutor(rs.getInt("idautores"));
				autor.setCodigoAutor(rs.getString("codigoAutor"));
				autor.setNombreAutor(rs.getString("nombreAutor"));
				autor.setNacionalidad(rs.getString("nacionalidad"));
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
		return autor;
	}

	public int modificarAutor(Producto autor) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_modificarAutor(?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, autor.getIdAutor());
			cs.setString(2, autor.getCodigoAutor());
			cs.setString(3, autor.getNacionalidad());
			cs.setString(4, autor.getNombreAutor());
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