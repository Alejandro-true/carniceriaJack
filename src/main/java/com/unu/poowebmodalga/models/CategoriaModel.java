package com.unu.poowebmodalga.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.unu.poowebmodalga.beans.Categoria;
import com.unu.poowebmodalga.utilitarios.Conexion;

public class CategoriaModel extends Conexion {
	CallableStatement cs;
	ResultSet rs;

	public List<Categoria> listarCategorias() {

		try {
			List<Categoria> categorias = new ArrayList<Categoria>();
			String sql = "CALL sp_listarCategoria()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();
			while (rs.next()) {
				Categoria categoria = new Categoria();
				categoria.setIdCategoria(rs.getInt("id_categoria"));
				categoria.setNombreCategoria(rs.getString("nombre"));
				categorias.add(categoria);
			}
			this.cerrarConexion();
			return categorias;
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}

	}

}
