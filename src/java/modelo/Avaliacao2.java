/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author aluno
 */
public class Avaliacao2 {
  private  int id,nota;
  private String descricao, nomeLivro, nomeUser;

    public Avaliacao2(int id,String nomeLivro, String nomeUser, String descricao,int nota) {
        this.id = id;
        this.nomeLivro = nomeLivro;
        this.nomeUser = nomeUser;
        this.descricao = descricao;
        this.nota = nota;
        
    }

    public Avaliacao2(String nomeLivro, String nomeUser, String descricao,int nota) {
        this.nomeLivro = nomeLivro;
        this.nomeUser = nomeUser;
        
        this.descricao = descricao;
        this.nota = nota;
        
    }

    public String getNomeLivro() {
        return nomeLivro;
    }

    public void setNomeLivro(String nomeLivro) {
        this.nomeLivro = nomeLivro;
    }

    public String getNomeUser() {
        return nomeUser;
    }

    public void setNomeUser(String nomeUser) {
        this.nomeUser = nomeUser;
    }

    

    public int getNota() {
        return nota;
    }

    public void setNota(int nota) {
        this.nota = nota;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
   
    
  
}
