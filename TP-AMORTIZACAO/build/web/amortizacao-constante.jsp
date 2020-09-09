
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
        <%@include file="WEB-INF/jspf/css.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortizacão constante</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <div class="jumbotron mt-5">
            <div class="container">
                <h1 class="display-4 font-weight-bold">Cálculo de amortização constante</h1>
                <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">O Sistema de Amortização Constante é o modelo de amortização em que ocorre o abatimento programado de valores de um empréstimo por um período determinado, onde o valor das parcelas a serem pagas é decrescente, sendo automaticamente descontado do valor inicial da dívida..</p>
            </div>
        </div>
    
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

        <table class="table">
            <thead class="thead-dark">
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
            </tbody>
        </table>
        <%@include file="WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
