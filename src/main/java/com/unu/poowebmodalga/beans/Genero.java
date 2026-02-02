package com.unu.poowebmodalga.beans;

public class Genero {
    
    private int idGenero;
    private String nombreGenero;
    private String abreviatura;
    
    public Genero() {
    }
    
    public Genero(String nombreGenero, String abreviatura) {
        this.nombreGenero = nombreGenero;
        this.abreviatura = abreviatura;
    }

    public int getIdGenero() {
        return idGenero;
    }

    public void setIdGenero(int idGenero) {
        this.idGenero = idGenero;
    }

    public String getNombreGenero() {
        return nombreGenero;
    }

    public void setNombreGenero(String nombreGenero) {
        this.nombreGenero = nombreGenero;
    }

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }
}