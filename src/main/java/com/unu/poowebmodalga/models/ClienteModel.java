package com.unu.poowebmodalga.models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.unu.poowebmodalga.beans.Cliente;
import com.unu.poowebmodalga.beans.Cliente.Estado;
import com.unu.poowebmodalga.utilitarios.Conexion;

public class ClienteModel extends Conexion {

	CallableStatement cs;
	ResultSet rs;

	public List<Cliente> listarClientes() {
		try {
			ArrayList<Cliente> clientes = new ArrayList<>();
			String sql = "CALL sp_listarClientes()";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			rs = cs.executeQuery();

			while (rs.next()) {
				Cliente cliente = new Cliente();
				cliente.setDni(rs.getString("dni"));
				cliente.setNombreCompleto(rs.getString("nombre_completo"));
				cliente.setEmail(rs.getString("email"));
				cliente.setDireccion(rs.getString("direccion"));
				cliente.setTelefono(rs.getString("telefono"));
				cliente.setEstado(Estado.valueOf(rs.getString("estado")));
				clientes.add(cliente);
			}

			this.cerrarConexion();
			return clientes;
		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
	}

	public int insertarCliente(Cliente cliente) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_insertarLibro(?,?,?,?,?,?)";

			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setString(1, cliente.getNombreCompleto());
			cs.setString(2, cliente.getTelefono());
			cs.setString(3, cliente.getDireccion());
			cs.setString(4, cliente.getEmail());
			cs.setString(5, cliente.getDni());
			cs.setString(6, cliente.getEstado() + "");
			filasAfectadas = cs.executeUpdate();
			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

	public Cliente obtenerCliente(int idCliente) {
		Cliente cliente = new Cliente();
		try {
			String sql = "CALL sp_obtenerLibro(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idCliente);
			rs = cs.executeQuery();

			if (rs.next()) {
				cliente.setIdCliente(rs.getInt(idCliente));
				cliente.setDni(rs.getString("dni"));
				cliente.setNombreCompleto(rs.getString("nombre_completo"));
				cliente.setEmail(rs.getString("email"));
				cliente.setDireccion(rs.getString("direccion"));
				cliente.setTelefono(rs.getString("telefono"));
				cliente.setEstado(Estado.valueOf(rs.getString("estado")));
			}
			this.cerrarConexion();
		} catch (Exception e) {
			e.printStackTrace();
			this.cerrarConexion();
			return null;
		}
		return cliente;
	}

	public int modificarLibro(Cliente cliente) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_modificarLibro(?,?,?,?,?,?,?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, cliente.getIdCliente());
			cs.setString(2, cliente.getNombreCompleto());
			cs.setString(3, cliente.getTelefono());
			cs.setString(4, cliente.getDireccion());
			cs.setString(5, cliente.getEmail());
			cs.setString(6, cliente.getDni());
			cs.setString(7, cliente.getEstado() + "");
			filasAfectadas = cs.executeUpdate();

			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

	public int inhabilitarCliente(int idCliente) {
		try {
			int filasAfectadas = 0;
			String sql = "CALL sp_inhabilitarCliente(?)";
			this.abrirConexion();
			cs = conexion.prepareCall(sql);
			cs.setInt(1, idCliente);
			filasAfectadas = cs.executeUpdate();

			this.cerrarConexion();
			return filasAfectadas;

		} catch (SQLException e) {
			e.printStackTrace();
			this.cerrarConexion();
			return 0;
		}
	}

}