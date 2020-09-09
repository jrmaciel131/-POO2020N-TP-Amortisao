
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Double valorEmprestimo;
    int nparcelas, taxa;
    Exception requestException = null;
    try {
        nparcelas = Integer.parseInt(request.getParameter("nparcelas"));
        taxa = Integer.parseInt(request.getParameter("taxa"));
        valorEmprestimo = Double.parseDouble(request.getParameter("valorEmprestimo"));
    } catch (Exception ex) {
        nparcelas = 0;
        taxa = 0;
        valorEmprestimo = 0.0;
        requestException = ex;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortizacão constante</title>
    </head>
    <body>
        <h4><a href="index.jsp">Voltar</a></h4>
        <h1>Java Server Pages</h1>
        <h2>Amortizacao Constante</h2>
        <form>
            Valor do emprestimo:
            <input type="number" name="valorEmprestimo"/>
            Taxa de juros ao ano:
            <input type="number" name="taxa"/>
            Numero de parcelas:
            <input type="number" name="nparcelas"/>
            <input type="submit" name="Gerar"/>
        </form>
        <Br/>

        <table border="1">
            <tr>
                <th>Mes</th>
                <th>Saldo devedor</th>
                <th>Juros</th>
                <th>Amortizacao</th>
                <th>Parcela</th>
            </tr>
            <% if (request.getParameter("nparcelas") == null) {%>
            <tr><td colspan="2">Sem parametro</td></tr>
            <% } else if (requestException != null) {%>
            <tr><td colspan="2">Parametro invalido</td></tr>
            <% } %>
            <% if (request.getParameter("taxa") == null) {%>
            <tr><td colspan="2">Sem parametro</td></tr>
            <% } else if (requestException != null) {%>
            <tr><td colspan="2">Parametro invalido</td></tr>
            <% } %>

            <% if (request.getParameter("valorEmprestimo") == null) {%>
            <tr><td colspan="2">Sem parametro</td></tr>
            <% } else if (requestException != null) {%>
            <tr><td colspan="2">Parametro invalido</td></tr>
            <% } %>


            <% Double saldo = valorEmprestimo;
                taxa = (taxa / 12);
                Double a = (valorEmprestimo / nparcelas);
                Double j = (valorEmprestimo * taxa) / 100;
                DecimalFormat df = new DecimalFormat("#0.00");
                df.format(taxa); %>

            <% for (int i = 1; i <= nparcelas; i++) {%>
            <tr>
                <td><%= i%></td>
                <% if (i == 1) {%>
                <td><%= valorEmprestimo%></td>
                <td><%= df.format(j)%></td>
                <% } else {%>
                <% j = (saldo * taxa) / 100;%>
                <td><%= df.format(saldo)%></td>
                <td><%= df.format(j)%></td>
                <% }%>
                <td><%= df.format(a)%></td>
                <th><%= df.format(a + j)%></th>
                    <% saldo = saldo - a; %>

            </tr>
            <% }%>
        </table>
    </body>
</html>
