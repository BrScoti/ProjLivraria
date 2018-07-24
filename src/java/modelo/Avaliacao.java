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
public class Avaliacao {
  private  int id,idUser, idLivro, nota;
  private String descricao;

    public Avaliacao(int id, int idUser, int idLivro,String descricao, int nota ) {
        this.id= id;
        this.idUser = idUser;
        this.idLivro = idLivro; 
        this.descricao = descricao;
        this.nota = nota;
    }

    public Avaliacao(int idUser, int idLivro,String descricao,int nota) {
        this.idUser = idUser;
        this.idLivro = idLivro;
        this.descricao = descricao;
        this.nota = nota;
    }

    public int getIdUser() {
        return idUser;
    }

    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }

    public int getIdLivro() {
        return idLivro;
    }

    public void setIdLivro(int idLivro) {
        this.idLivro = idLivro;
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
