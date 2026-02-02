package com.unu.poowebmodalga.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.unu.poowebmodalga.beans.Autor;
import com.unu.poowebmodalga.beans.Genero;
import com.unu.poowebmodalga.beans.Libro;
import com.unu.poowebmodalga.dto.LibroGenero;
import com.unu.poowebmodalga.utilitarios.Conexion;

public class LibrosModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;

	public List<Libro> listarLibros() {
		try {
			ArrayList<Libro> libros = new ArrayList<>();
			String sql = "CALL sp_listarLibros()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Libro libro = new Libro();
				libro.setIdLibro(rs.getInt("idlibros"));
				libro.setNombreLibro(rs.getString("nombre_libro"));
				libro.setExistencia(rs.getInt("existencia"));
				libro.setPrecio(rs.getDouble("precio"));
				libro.setDescripcion(rs.getString("descripcion"));
				libro.setIdAutor(rs.getInt("autores_idautores"));
				libro.setIdGenero(rs.getInt("generos_idgeneros"));
				libro.setNombreAutor(rs.getString("nombreAutor"));
				libro.setNombreGenero(rs.getString("nombre_genero"));
				libros.add(libro);
			}

			this.cerrarConexion();
			return libros;
		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
	}

	public int insertarLibro(Libro libro) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_insertarLibro(?,?,?,?,?,?)";

			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, libro.getNombreLibro());
			cs.setInt(2, libro.getExistencia());
			cs.setDouble(3, libro.getPrecio());
			cs.setString(4, libro.getDescripcion());
			cs.setInt(5, libro.getIdAutor());
			cs.setInt(6, libro.getIdGenero());
			filasAfectadas = cs.executeUpdate();
			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

	public Libro obtenerLibro(int idLibro) {
		Libro libro = new Libro();
		try {
			String sql = "CALL sp_obtenerLibro(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idLibro);
			rs = cs.executeQuery();

			if (rs.next()) {
				libro.setIdLibro(rs.getInt("idlibros"));
				libro.setNombreLibro(rs.getString("nombre_libro"));
				libro.setExistencia(rs.getInt("existencia"));
				libro.setPrecio(rs.getDouble("precio"));
				libro.setDescripcion(rs.getString("descripcion"));
				libro.setIdAutor(rs.getInt("autores_idautores"));
				libro.setIdGenero(rs.getInt("generos_idgeneros"));
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
		return libro;
	}

	public int modificarLibro(Libro libro) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_modificarLibro(?,?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, libro.getIdLibro());
			cs.setString(2, libro.getNombreLibro());
			cs.setInt(3, libro.getExistencia());
			cs.setDouble(4, libro.getPrecio());
			cs.setString(5, libro.getDescripcion());
			cs.setInt(6, libro.getIdAutor());
			cs.setInt(7, libro.getIdGenero());
			filasAfectadas = cs.executeUpdate();

			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

	public int eliminarLibro(int idLibro) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_eliminarLibro(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idLibro);
			filasAfectadas = cs.executeUpdate();

			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

	// Métodos auxiliares para los combos
	public List<Autor> listarAutores() {
		try {
			ArrayList<Autor> autores = new ArrayList<>();
			String sql = "CALL sp_listarAutores()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Autor autor = new Autor();
				autor.setIdAutor(rs.getInt("idautores"));
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

	public List<Genero> listarGeneros() {
		try {
			ArrayList<Genero> generos = new ArrayList<>();
			String sql = "CALL sp_listarGeneros()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Genero genero = new Genero();
				genero.setIdGenero(rs.getInt("idgeneros"));
				genero.setNombreGenero(rs.getString("nombre_genero"));
				genero.setAbreviatura(rs.getString("abreviatura"));
				generos.add(genero);
			}

			this.cerrarConexion();
			return generos;
		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
	}

	public List<LibroGenero> obtenerLibroPorGenero() {
		List<LibroGenero> librogenero = new ArrayList<LibroGenero>();
		try {
			String sql = "call sp_ObtenerLibroGenero()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				librogenero.add(new LibroGenero(rs.getString("Genero"), rs.getInt("total")));
			}
			return librogenero;
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
		}
		return null;
	}
}