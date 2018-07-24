package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AcessoBD {

    private String stringDeConexao;
    private Connection conexao;

    public AcessoBD(String nomeBanco) {
        stringDeConexao = "jdbc:postgresql://localhost/"
                + nomeBanco + "?user=postgres&password=postgres";
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AcessoBD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void conectar() {
        try {
            conexao = DriverManager.getConnection(stringDeConexao);
        } catch (SQLException ex) {
            Logger.getLogger(AcessoBD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void desconectar() {
        try {
            conexao.close();
        } catch (SQLException ex) {
            Logger.getLogger(AcessoBD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Connection getConexao() {
        return conexao;
    }

}
