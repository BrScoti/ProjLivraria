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
public class Usuario {
    private int id;
    private String email;
    private String nome;
    private String senha; 
    List <Avaliacao> listAvaliacoes;
    public Usuario(String nome, String email, String senha) {
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.listAvaliacoes= new ArrayList();
    }

    public Usuario(int id, String email, String nome, String senha) {
        this.id = id;
        this.email = email;
        this.nome = nome;
        this.senha = senha;
        this.listAvaliacoes= new ArrayList();
    }
    public Usuario(int id, String email, String nome) {
        this.id = id;
        this.email = email;
        this.nome = nome;
        
        this.listAvaliacoes= new ArrayList();
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    
    
    
}
