/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package negocio;

import java.sql.Date;
import modelo.Avaliacao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Avaliacao;
import modelo.Avaliacao2;
import util.AcessoBD;

/**
 *
 * @author aluno
 */
public class AvaliacaoDAO {

    private AcessoBD acessoBD;

    public AvaliacaoDAO(AcessoBD acessoBD) {
        this.acessoBD = acessoBD;
    }

    public void inserir(Avaliacao avaliacao) {
        acessoBD.conectar();

        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement(" insert into avaliacao (iduser,idlivro,descricao,nota) values(?,?,?,?)");
            pstm.setInt(1, avaliacao.getIdUser());
            pstm.setInt(2, avaliacao.getIdLivro());
            pstm.setString(3, avaliacao.getDescricao());
            pstm.setInt(4, avaliacao.getNota());
            
            pstm.execute();
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(AvaliacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Avaliacao> listarTodos() {
        List<Avaliacao> resultado = new ArrayList<>();
        try {
            acessoBD.conectar();
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from avaliacao order by id");
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
            Logger.getLogger(AvaliacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return resultado;
    }
    public List<Avaliacao2> listarTodosPorNome() {
        List<Avaliacao2> resultado = new ArrayList<>();
        try {
            acessoBD.conectar();
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select a.id,u.nome, l.nome,a.descricao,a.nota from avaliacao a "+
                    "inner join livro l on l.id=a.idlivro inner join usuario u on u.id=a.iduser;");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                resultado.add(new Avaliacao2(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5)
                ));
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(AvaliacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return resultado;
    }
    public void excluir(int id) {
        acessoBD.conectar();
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("delete from avaliacao where id=? ");
            pstm.setInt(1, id);
            pstm.execute();
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(AvaliacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public Avaliacao listarAvaliacao(int id) {
        acessoBD.conectar();
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from avaliacao where id=? ");
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                return new Avaliacao(
                        rs.getInt("id"),
                        rs.getInt("idUser"),
                        rs.getInt("idLivro"),
                        rs.getString("descricao"),
                        rs.getInt("nota")
                );
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(AvaliacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void editarAvaliacao(int id, Avaliacao e) {
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("update avaliacao set descricao= ?,nota=? where id=? ");
            pstm.setString(1, e.getDescricao());
            pstm.setString(2, e.getDescricao());
            pstm.setInt(3, id);

            pstm.executeUpdate();

            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(AvaliacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    
}
