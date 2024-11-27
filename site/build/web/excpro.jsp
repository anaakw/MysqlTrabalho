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
            int cod;
            cod = Integer.parseInt(request.getParameter("codigo"));
            
            try {
                // Carrega o driver do MySQL
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Estabelece a conexão com o banco de dados
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3307/banco", "site", "site");
                
                // Prepara a instrução SQL para excluir o produto com o código fornecido
                PreparedStatement st = conecta.prepareStatement("DELETE FROM produto WHERE codigo=?");
                st.setInt(1, cod);
                
                // Executa a atualização e verifica se foi realizada com sucesso
                int resultado = st.executeUpdate();
                
                if (resultado == 0) {
                    out.print("Este Produto NÃO EXISTE!!!");
                } else {
                    out.print("O produto de código " + cod + " foi excluído com sucesso!");
                }
                
                // Fecha a conexão
                st.close();
                conecta.close();
                
            } catch (Exception erro) {
                String mensagemErro = erro.getMessage();
                out.print("Entre em contato com o suporte e informe o erro: " + mensagemErro);
            }
        %>
    </body>
</html>
