<%@page import="java.text.DecimalFormat"%>
<%@page import="java.lang.Math"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Double saldodevedor, taxa, resultj, resultp, resulta, parcelafixa;
    int nparcelas;
    Exception requestException = null;
    try {
        nparcelas = Integer.parseInt(request.getParameter("nparcelas"));
        taxa = Double.parseDouble(request.getParameter("taxa"));
        saldodevedor = Double.parseDouble(request.getParameter("valorEmprestimo"));
        resultj = 0.0;
        resulta = 0.0;
        parcelafixa = 0.0;
        resultp = 0.0;

    } catch (Exception ex) {
        nparcelas = 0;
        taxa = 0.0;
        saldodevedor = 0.0;
        requestException = ex;
        resultj = 0.0;
        resulta = 0.0;
        parcelafixa = 0.0;
        resultp = 0.0;
    }
%>
<html>
    <head>
        <%@include file="WEB-INF/jspf/css.jspf" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortizacão - Sistema Price</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <div class="jumbotron mt-5">
            <div class="container">
                <h1 class="display-4 font-weight-bold">Cálculo de amortização pelo sistema price.</h1>
                <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">Tabela Price, também chamado de sistema francês de amortização, é um método usado em amortização de empréstimo 
                    cuja principal característica é apresentar prestações (ou parcelas) iguais. 
                    O método foi apresentado em 1771 por Richard Price em sua obra "Observações sobre Pagamentos Remissivos.</p>
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
            <table class="table border" >
                <thead class="thead-dark">
                    <tr>
                        <th>Mês</th>
                        <th>Saldo devedor</th>
                        <th>Juros</th>
                        <th>Amortizacao</th>
                        <th>Parcela</th>
                    </tr>
                    <% if (request.getParameter("nparcelas") == null) {%>
                    <tr><td colspan="5">Sem parametro</td></tr>
                    <% } else if (requestException != null) {%>
                    <tr><td colspan="5">Parametro invalido</td></tr>
                    <% } %>
                    <% if (request.getParameter("taxa") == null) {%>
                    <tr><td colspan="5">Sem parametro</td></tr>
                    <% } else if (requestException != null) {%>
                    <tr><td colspan="5">Parametro invalido</td></tr>
                    <% } %>

                    <% if (request.getParameter("valorEmprestimo") == null) {%>
                    <tr><td colspan="5">Sem parametro</td></tr>
                    <% } else if (requestException != null) {%>
                    <tr><td colspan="5">Parametro invalido</td></tr>
                    <% } %>


                    <% Double saldo = saldodevedor;
                        taxa = (taxa / 12);
                        parcelafixa = saldodevedor * (Math.pow(1 + (taxa / 100), nparcelas) * (taxa / 100)) / (Math.pow(1 + (taxa / 100), nparcelas) - 1);
                        Double j = (saldodevedor * taxa) / 100;
                        DecimalFormat df = new DecimalFormat("#0.00");
                        df.format(taxa); %>

                    <% for (int i = 1; i <= nparcelas; i++) {
                            Double a = (parcelafixa - j);
                    %>
                    <tr>
                        <td><%= i%></td>
                        <% if (i == 1) {%>
                        <td><%= saldodevedor%></td>
                        <td><%= df.format(j)%></td>
                        <%
                            resultj = +j;
                        } else {
                        %>
                        <% j = (saldo * taxa) / 100;%>
                        <td><%= df.format(saldo)%></td>
                        <td><%= df.format(j)%></td>
                        <%
                                resultj += j;
                            }
                        %>
                        <td><%= df.format(a)%></td>
                        <% 
                          resulta += a;
                          resultp += parcelafixa;
                        %>
                        <td><%= df.format(parcelafixa)%></td>
                            <%saldo = saldo - parcelafixa;%>


                    </tr>
                    <% }%>
                    <tr class="bg-dark text-white">
                      <td class="font-weight-bold">Totais</td>
                        <td>0</td>
                        <td><%= df.format(resultj)%></td>
                        <td><%= df.format(resulta)%></td>
                        <td><%= df.format(resultp)%></td>
                    </tr>
                    </tbody>
            </table>
        </div>

        <%@include file="WEB-INF/jspf/scripts.jspf" %>
    </body>
</html>
