/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package negocio;

import java.sql.Date;
import modelo.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Avaliacao;
import util.AcessoBD;

/**
 *
 * @author aluno
 */
public class UsuarioDAO {

    private AcessoBD acessoBD;

    public UsuarioDAO(AcessoBD acessoBD) {
        this.acessoBD = acessoBD;
    }

    public void inserir(Usuario evento) {
        acessoBD.conectar();

        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement(" insert into usuario (nome,email,senha) values(?,?,?)");
            pstm.setString(1, evento.getNome());
            pstm.setString(2, evento.getEmail());
            pstm.setString(3, evento.getSenha());
            pstm.execute();
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Usuario> listarTodos() {
        List<Usuario> resultado = new ArrayList<>();
        try {
            acessoBD.conectar();
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from usuario order by id");
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                resultado.add(new Usuario(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("nome"),
                        rs.getString("senha")
                ));
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return resultado;
    }

    public void excluir(int id) {
        acessoBD.conectar();
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("delete from usuario where id=? ");
            pstm.setInt(1, id);
            pstm.execute();
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public Usuario listarUsuario(int id) {
        acessoBD.conectar();
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select id,nome,email from usuario where id=? ");
            pstm.setInt(1, id);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                return new Usuario(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email")
                );
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean encontrarUsuario(String email, String senha) {
        acessoBD.conectar();
        Usuario user = null;
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from usuario where email=? ");
            pstm.setString(1, email);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                user = new Usuario(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email"),
                        rs.getString("senha")
                );
            }
            acessoBD.desconectar();
            if (user == null) {
                return false;

            } else {
                if (user.getSenha().equals(senha)) {
                    return true;
                } else {
                    return false;
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

//    public Usuario listarUsuario(String nome) {
//        acessoBD.conectar();
//        try {
//            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from usuario where nome=? ");
//            pstm.setString(1, nome);
//            ResultSet rs = pstm.executeQuery();
//            while (rs.next()) {
//                return new Usuario(
//                        rs.getInt("id"),
//                        rs.getString("nome"),
//                        rs.getString("email"),
//                        rs.getString("senha")
//                );
//            }
//            acessoBD.desconectar();
//        } catch (SQLException ex) {
//            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
    public Usuario listarUsuario(String email) {
        acessoBD.conectar();
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select id,nome,email from usuario where email=? ");
            pstm.setString(1, email);
            ResultSet rs = pstm.executeQuery();
            while (rs.next()) {
                return new Usuario(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("email")
                );
            }
            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void editarUsuario(int id, Usuario e) {
        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("update usuario set nome= ?,email= ?,senha= ? where id=? ");
            pstm.setString(1, e.getNome());
            pstm.setString(2, e.getEmail());
            pstm.setString(3, e.getSenha());
            pstm.setInt(4, id);

            pstm.executeUpdate();

            acessoBD.desconectar();
        } catch (SQLException ex) {
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public List<Avaliacao> listAvaliacaoUser(int idUser) {
        List<Avaliacao> resultado = new ArrayList<>();

        acessoBD.conectar();

        try {
            PreparedStatement pstm = acessoBD.getConexao().prepareStatement("select * from avaliacao where idUser=? ");
            pstm.setInt(1, idUser);
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
            Logger.getLogger(UsuarioDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultado;
    }
}
