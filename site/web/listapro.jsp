<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listagem de Produtos</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                width: 80%;
                max-width: 1000px;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #5741bd;
                color: white;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            .error {
                color: red;
                font-weight: bold;
                text-align: center;
            }
            .footer {
                text-align: center;
                font-size: 12px;
                color: #888;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Listagem de Produtos</h1>
            <%
                try {
                    // Fazer a conexão com o Banco de Dados
                    Connection conecta;
                    PreparedStatement st;
                    // Carregar o driver do MySQL
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3307/banco", "site", "site");
                    // Listar os dados da tabela produto do banco de dados
                    st = conecta.prepareStatement("SELECT * FROM produto");
                    // Método executeQuery() roda o código SQL e traz os dados que são atribuídos à variável rs
                    ResultSet rs = st.executeQuery();
            %>
            
            <table>
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Nome</th>
                        <th>Marca</th>
                        <th>Preço</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Para mostrarmos todos os resultados, manipulamos um por um
                        // Fazemos isso com a estrutura de repetição while()
                        // Que irá iterar sobre o resultado enquanto houverem linhas
                        while (rs.next()) {
                    %>
                        <tr>
                            <td><%= rs.getString("codigo") %></td>
                            <td><%= rs.getString("nome") %></td>
                            <td><%= rs.getString("marca") %></td>
                            <td><%= rs.getString("preco") %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            
            <%
                } catch(Exception x) {
            %>
                    <div class="error">Mensagem de erro: <%= x.getMessage() %></div>
            <%
                }
            %>

            <div class="footer">
                <p>&copy; 2024 - Sistema de Produtos</p>
            </div>
        </div>
    </body>
</html>
