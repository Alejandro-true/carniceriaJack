package com.unu.poowebmodalga.beans;

public class Libro {
    
    private int idLibro;
    private String nombreLibro;
    private int existencia;
    private double precio;
    private String descripcion;
    private int idAutor;
    private int idGenero;
    
    // Para mostrar información completa
    private String nombreAutor;
    private String nombreGenero;
    
    public Libro() {
    }
    
    public Libro(String nombreLibro, int existencia, double precio, String descripcion, int idAutor, int idGenero) {
        this.nombreLibro = nombreLibro;
        this.existencia = existencia;
        this.precio = precio;
        this.descripcion = descripcion;
        this.idAutor = idAutor;
        this.idGenero = idGenero;
    }

    // Getters y Setters
    public int getIdLibro() {
        return idLibro;
    }

    public void setIdLibro(int idLibro) {
        this.idLibro = idLibro;
    }

    public String getNombreLibro() {
        return nombreLibro;
    }

    public void setNombreLibro(String nombreLibro) {
        this.nombreLibro = nombreLibro;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getIdAutor() {
        return idAutor;
    }

    public void setIdAutor(int idAutor) {
        this.idAutor = idAutor;
    }

    public int getIdGenero() {
        return idGenero;
    }

    public void setIdGenero(int idGenero) {
        this.idGenero = idGenero;
    }

    public String getNombreAutor() {
        return nombreAutor;
    }

    public void setNombreAutor(String nombreAutor) {
        this.nombreAutor = nombreAutor;
    }

    public String getNombreGenero() {
        return nombreGenero;
    }

    public void setNombreGenero(String nombreGenero) {
        this.nombreGenero = nombreGenero;
    }
}