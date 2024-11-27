<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Produto</title>
    </head>
    <body>
        <%
        // Receber os dados digitados no formulário cadpro.html
        int c;
        String n, m;
        double p;
        
        // Correção no nome do método 'getParameter'
        c = Integer.parseInt(request.getParameter("codigo"));
        n = request.getParameter("nome");
        m = request.getParameter("marca");
        p = Double.parseDouble(request.getParameter("preco"));

        Connection conecta = null;  // Declare a variável 'conecta' fora do bloco try
        PreparedStatement st = null;

        try {
            // Realizar a Conexão com o Banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3307/banco", "site", "site");

            // Inserir os dados na tabela
            st = conecta.prepareStatement("INSERT INTO produto (codigo, nome, marca, preco) VALUES (?, ?, ?, ?)");
            st.setInt(1, c);
            st.setString(2, n);
            st.setString(3, m);
            st.setDouble(4, p); // Corrigido para setDouble
            st.executeUpdate(); // Executar o Comando de inserção

            out.print("Cadastro Realizado com sucesso!");
        } catch (Exception x) {
            // Corrigido 'Exception' e 'getMessage'
            out.print("Erro: " + x.getMessage());
        } finally {
            // Fechar a conexão com o banco de dados
            try {
                if (conecta != null) {
                    conecta.close();
                }
                if (st != null) {
                    st.close();
                }
            } catch (Exception e) {
                out.print("Erro ao fechar a conexão: " + e.getMessage());
            }
        }
        %>
    </body>
</html>
