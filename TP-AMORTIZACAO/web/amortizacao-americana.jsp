<%@page import="java.text.DecimalFormat"%>
<%@page import="java.lang.Math"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  DecimalFormat df = new DecimalFormat("#0.00");
  DecimalFormat inteiro = new DecimalFormat("#0");
  int parcelas = 0;
  float emprestimo = 0;
  float juros = 0;

  try {
    parcelas = Integer.parseInt(request.getParameter("nparcelas"));
    juros = Float.parseFloat(request.getParameter("taxa"));
    emprestimo = Float.parseFloat(request.getParameter("valorEmprestimo"));
  } catch (Exception ex) {
    System.err.println(ex);
  }

%>
<html>
  <head>
    <%@include file="WEB-INF/jspf/css.jspf" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Amortizacão Americana</title>
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
          <h1 class="display-4 font-weight-bold">Cálculo de amortização americana</h1>
          <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">É um sistema de amortização de 
            dívidas onde os juros de um empréstimo são pagos periodicamente, porém a quitação do empréstimo se dá por 
            meio de uma única parcela que deverá ser paga ao final do contrato</p>
          <form class="mt-5">
            <div class="input-group-lg mb-3">
              <label for="emprestimo">Valor do emprestimo</label>
              <input type="number" name="valorEmprestimo" class="form-control" id="emprestimo">
            </div>

            <div class="input-group-lg mb-3">
              <label  for="juros">Taxa de juros ao ano</label>
              <input type="text" name="taxa" class="form-control" id="juros">
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
        <table class="table border">
          <thead class="thead-dark">
            <tr>
              <th scope="col">Mês</th>
              <th scope="col">Saldo devedor</th>
              <th scope="col">Amortização</th>
              <th scope="col">Juros</th>
              <th scope="col">Parcela</th>
            </tr>
          </thead>

          <tbody>
            <tr>
              <th scope="col">#</th>
              <td><%= df.format(emprestimo)%></td>
              <td>-</td>
              <td>-</td>
              <td>-</td>
            </tr>

            <%
              float totalJuros = 0;
              float amortizacao = 0;
              int mes;
              float saldoDevedor, prestacao;

              for (int i = 1; i <= parcelas; i++) {
                float jurosPrestacao = emprestimo * (juros / 100);
                totalJuros += jurosPrestacao;
                mes = i;
                saldoDevedor = emprestimo;
                prestacao = jurosPrestacao;

                if (mes == parcelas) {
                  prestacao = jurosPrestacao + emprestimo;
                  amortizacao = emprestimo;
                  saldoDevedor = 0;
                } else {
                  prestacao = jurosPrestacao;
                }
            %>

            <tr>
              <th scope="col">  <%= mes%>   </th>
              <td><%= mes == parcelas ? inteiro.format(saldoDevedor) : df.format(saldoDevedor)%> </td>
              <td><%= mes != parcelas ? "-" : df.format(amortizacao)%></td>
              <td><%= df.format(jurosPrestacao)%> </td>
              <td><%= df.format(prestacao)%></td>
            </tr>

            <%
              }
            %>
            <tr class="bg-dark text-white">
              <th scope="row">TOTAIS</th>
              <td>-</td>
              <td><%= df.format(amortizacao)%></td>
              <td><%= df.format(Math.round(totalJuros))%></td>
              <td><%= df.format(emprestimo + totalJuros)%></td>
            </tr>
          </tbody>
        </table>

      </div>
    </main>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    <%@include file="WEB-INF/jspf/scripts.jspf" %>
  </body>
</html>

