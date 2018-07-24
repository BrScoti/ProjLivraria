/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aluno
 */
public class Livro {
   private int id;
   private String nome,autor;
  List <Avaliacao> listAvaliacoes;
    public Livro(int id, String nome, String autor) {
        this.id = id;
        this.nome = nome;
        this.autor = autor;
        this.listAvaliacoes= new ArrayList();
    }

    public Livro(String nome, String autor) {
        this.nome = nome;
        this.autor = autor;
        this.listAvaliacoes= new ArrayList();
    }

    
    public String getAutor() {
        return autor;
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    
}
