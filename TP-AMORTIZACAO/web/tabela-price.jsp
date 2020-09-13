<%@page import="java.text.DecimalFormat"%>
<%@page import="java.lang.Math"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  float saldodevedor, taxa, resultj, resultp, resulta, parcelafixa;
  int nparcelas;
  Exception requestException = null;
  try {
    nparcelas = Integer.parseInt(request.getParameter("nparcelas"));
    taxa = Float.parseFloat(request.getParameter("taxa"));
    saldodevedor = Float.parseFloat(request.getParameter("valorEmprestimo"));
    resultj = 0;
    resulta = 0;
    parcelafixa = 0;
    resultp = 0;

  } catch (Exception ex) {
    nparcelas = 0;
    taxa = 0;
    saldodevedor = 0;
    requestException = ex;
    resultj = 0;
    resulta = 0;
    parcelafixa = 0;
    resultp = 0;
  }
%>
<html>
  <head>
    <%@include file="WEB-INF/jspf/css.jspf" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Amortizacão - Sistema Price</title>
    <style>
      input {
        max-width: 50%;
      }

      form label {
        font-size: 18px;
      }
    </style>
  </head>
  <body>
    <%@include file="WEB-INF/jspf/menu.jspf" %>
    <main role="main">
      <div class="jumbotron mt-5">
        <div class="container">
          <h1 class="display-4 font-weight-bold">Cálculo de amortização pelo sistema price.</h1>
          <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">Tabela Price, também chamado de sistema francês de amortização, é um método usado em amortização de empréstimo 
            cuja principal característica é apresentar prestações (ou parcelas) iguais. 
            O método foi apresentado em 1771 por Richard Price em sua obra "Observações sobre Pagamentos Remissivos.</p>
          <form class="mt-5">
            <div class="input-group-lg mb-3">
              <label for="emprestimo">Valor do emprestimo</label>
              <input type="number" name="valorEmprestimo" class="form-control" id="emprestimo">
            </div>

            <div class="input-group-lg mb-3">
              <label  for="juros">Taxa de juros ao ano</label>
              <input type="number" name="taxa" class="form-control" id="juros">
            </div>

            <div class="input-group-lg mb-3">
              <label for="parcelas">Numero de parcelas</label>
              <input type="number" name="nparcelas" class="form-control" id="parcelas">
            </div>

            <button type="submit" class="btn btn-lg btn-primary">Calcular</button>
          </form>
        </div>
      </div>
      <div class="container">
        <table class="table mt-5 mb-5 border">
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


            <% float saldo = saldodevedor;
              taxa = (taxa / 12)/100;
              parcelafixa = (float) (saldodevedor * (Math.pow(1 + (taxa), nparcelas) * taxa) / (Math.pow(1 + (taxa), nparcelas) - 1));
              float j = (saldodevedor * taxa);
              DecimalFormat df = new DecimalFormat("#0.00");
              df.format(taxa); %>

            <% for (int i = 1; i <= nparcelas; i++) {
                float a = (parcelafixa - j);
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
              <% j = (saldo * taxa);%>
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
              <%saldo = saldo - a;%>


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
    </main>
    <%@include file="WEB-INF/jspf/scripts.jspf" %>
  </body>
</html>
