/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package negocio;

import java.sql.Date;
import modelo.Livro;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Avaliacao;
import modelo.Livro;
import util.AcessoBD;

/**
 *
 * @author aluno
 */
public class LivroDAO {

    private AcessoBD acessoBD;

    public LivroDAO(AcessoBD acessoBD) {
        this.acessoBD = acessoBD;
    }

    public void inserir(Livro livro) {
        acessoBD.conectar();

        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement(" insert into livro (nome,autor) values(?,?)");
            pstm.setString(1, livro.getNome());
            pstm.setString(2, livro.getAutor());
            pstm.execute();
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(LivroDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Livro> listarTodos() {
        List<Livro> resultado = new ArrayList<>();
        try {
            acessoBD.conectar();
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from livro order by id");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                resultado.add(new Livro(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("autor")
                ));
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(LivroDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return resultado;
    }

    public void excluir(int id) {
        acessoBD.conectar();
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("delete from livro where id=? ");
            pstm.setInt(1, id);
            pstm.execute();
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(LivroDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public Livro listarLivro(int id) {
        acessoBD.conectar();
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from livro where id=? ");
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                return new Livro(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("autor")
                );
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(LivroDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void editarLivro(int id, Livro e) {
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("update livro set nome= ?,autor= ? where id=? ");
            pstm.setString(1, e.getNome());
            pstm.setString(2, e.getAutor());
            pstm.setInt(3, id);

            pstm.executeUpdate();

            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(LivroDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public List<Avaliacao> listAvaliacaoLivro(int idLivro, Avaliacao avaliacao) {
        List<Avaliacao> resultado = new ArrayList<>();

        acessoBD.conectar();

        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from avaliacao where idUser=? ");
            pstm.setInt(1, idLivro);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                resultado.add(new Avaliacao(
                        rs.getInt("id"),
                        rs.getInt("idUser"),
                        rs.getInt("idLivro"),
                        rs.getString("descricao"),
                        rs.getInt("nota")
                ));
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(LivroDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultado;
    }
}
