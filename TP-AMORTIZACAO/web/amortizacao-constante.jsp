
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  float saldodevedor, taxa, P, a, resultJ, resultA, resultP, nparcelas;
  Exception requestException = null;
  try {
    nparcelas = Float.parseFloat(request.getParameter("nparcelas"));
    taxa = Float.parseFloat(request.getParameter("taxa"));
    saldodevedor = Float.parseFloat(request.getParameter("valorEmprestimo"));
    resultJ = 0;
    resultA = 0;
    resultP = 0;
    a = 0;

  } catch (Exception ex) {
    nparcelas = 0;
    taxa = 0;
    saldodevedor = 0;
    requestException = ex;
    resultJ = 0;
    resultA = 0;
    a = 0;
    resultP = 0;
  }
%>
<html>
  <head>
    <%@include file="WEB-INF/jspf/css.jspf" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Amortizacão constante</title>

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
          <h1 class="display-4 font-weight-bold">Cálculo de amortização constante</h1>
          <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">O Sistema de Amortização Constante é o modelo de amortização em que ocorre o abatimento programado de valores de um empréstimo por um período determinado, onde o valor das parcelas a serem pagas é decrescente, sendo automaticamente descontado do valor inicial da dívida.</p>
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
              taxa = (taxa / 12);
              a = (saldodevedor / nparcelas);
              resultA = a * nparcelas;
              float j = (saldodevedor * taxa) / 100;
              DecimalFormat df = new DecimalFormat("#0.00");
                      df.format(taxa); %>

            <% for (int i = 1; i <= nparcelas; i++) {%>
            <tr>
              <td><%= i%></td>
              <% if (i == 1) {%>
              <td><%= saldodevedor%></td>
              <td><%= df.format(j)%></td>
              <%
              } else {
              %>
              <% j = (saldo * taxa) / 100;%>
              <td><%= df.format(saldo)%></td>
              <td><%= df.format(j)%></td>
              <%
                  resultJ += j;
                }
              %>
              <td><%= df.format(a)%></td>
              <%
                P = a + j;
                resultP += P;
              %>
              <td><%= df.format(P)%></td>
              <%saldo = saldo - a;%>
            </tr>
            <% }%>
            <tr class="bg-dark text-white">
              <td class="font-weight-bold">TOTAIS</td>
              <td>0 </td>
              <td><%= df.format(resultJ)%></td>
              <td><%= df.format(resultA)%></td>
              <td><%= df.format(resultP)%></td>

            </tr>
            </tbody>
        </table>
      </div>
    </main>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    <%@include file="WEB-INF/jspf/scripts.jspf" %>
  </body>
</html>
