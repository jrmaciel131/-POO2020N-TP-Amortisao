
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Double saldodevedor, taxa, resultsaldo, resultj, resulta;
    int nparcelas;
    Exception requestException = null;
    try {
        nparcelas = Integer.parseInt(request.getParameter("nparcelas"));
        taxa = Double.parseDouble(request.getParameter("taxa"));
        saldodevedor = Double.parseDouble(request.getParameter("valorEmprestimo"));
        resultsaldo = 0.0;
        resultj = 0.0;
        resulta = 0.0;
        
    } catch (Exception ex) {
        nparcelas = 0;
        taxa = 0.0;
        saldodevedor = 0.0;
        requestException = ex;
        resultsaldo = 0.0;
        resultj = 0.0;
        resulta = 0.0;
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
                <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">O Sistema de Amortização Constante é o modelo de amortização em que ocorre o abatimento programado de valores de um empréstimo por um período determinado, onde o valor das parcelas a serem pagas é decrescente, sendo automaticamente descontado do valor inicial da dívida.</p>
                <form>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Valor do emprestimo</label>
                        <input type="number" name="valorEmprestimo" class="form-control" id="exampleInputPassword1">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">Taxa de juros ao ano</label>
                        <input type="number" name="taxa" class="form-control" id="exampleInputPassword1">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">Numero de parcelas</label>
                        <input type="number" name="nparcelas" class="form-control" id="exampleInputPassword1">
                    </div>

                    <button type="submit" class="btn btn-primary">Calcular</button>
                </form>
            </div>
        </div>
        <div class="container">
            <table class="table " >
                <thead class="thead-dark">
                    <tr>
                        <th>Mês</th>
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


                    <% Double saldo = saldodevedor;
                        taxa = (taxa / 12);
                        Double a = (saldodevedor / nparcelas);
                        Double j = (saldodevedor * taxa) / 100;
                        DecimalFormat df = new DecimalFormat("#0.00");
                        df.format(taxa); %>

                    <% for (int i = 1; i <= nparcelas; i++) {%>
                    <tr>
                        <td><%= i%></td>
                        <% if (i == 1) {%>
                        <td><%= saldodevedor%></td>
                        <td><%= df.format(j)%></td>
                        <%
                            resultsaldo = +saldodevedor;
                            resultj = +j;
                        } else {
                        %>
                        <% j = (saldo * taxa) / 100;%>
                        <td><%= df.format(saldo)%></td>
                        <td><%= df.format(j)%></td>
                        <%
                            resultsaldo =+ saldodevedor;
                            resultj += j;
                            }
                        %>
                        <td><%= df.format(a)%></td>
                        <% resulta += a; %>
                        <th><%= df.format(a + j)%></th>
                        <%saldo = saldo - a;%>
                        

                    </tr>
                    <% }%>
                    <tr>
                        <td>#</td>
                        <td><%= df.format(resultsaldo)%></td>
                        <td><%= df.format(resultj)%></td>
                        <td><%= df.format(resulta)%></td>
                        <th> Totais</th>
                    </tr>
                    </tbody>
            </table>
        </div>

        <%@include file="WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
