<%@page import="java.text.DecimalFormat"%>
<%@page import="java.lang.Math"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  DecimalFormat df = new DecimalFormat("#0.00");
  float saldodevedor, taxa;
  int parcelas;
  try {
    parcelas = Integer.parseInt(request.getParameter("nparcelas"));
    taxa = Float.parseFloat(request.getParameter("taxa"));
    saldodevedor = Float.parseFloat(request.getParameter("valorEmprestimo"));
  } catch (Exception ex) {
    out.println(ex);
    parcelas = 0;
    taxa = 0;
    saldodevedor = 0;

  }
%>
<html>
  <head>
    <%@include file="WEB-INF/jspf/css.jspf" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Amortizacão - SAF</title>
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
      <div class="jumbotron mt-4">
        <div class="container">
          <h1 class="display-4 font-weight-bold">Cálculo de amortização pelo sistema de amortização francês (SAF.</h1>
          <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">Tabela Price, também chamado de sistema francês de amortização, é um método usado em amortização de empréstimo 
            cuja principal característica é apresentar prestações (ou parcelas) iguais. 
            O método foi apresentado em 1771 por Richard Price em sua obra "Observações sobre Pagamentos Remissivos.</p>
          <form class="mt-5">
            <div class="input-group-lg mb-3">
              <label for="emprestimo">Valor do empréstimo:</label>
              <input type="number" name="valorEmprestimo" class="form-control" id="emprestimo">
            </div>

            <div class="input-group-lg mb-3">
              <label  for="juros">Taxa de juros anual:</label>
              <input type="text" name="taxa" class="form-control" id="juros">
            </div>

            <div class="input-group-lg mb-3">
              <label for="parcelas">Número de parcelas:</label>
              <input type="number" name="nparcelas" class="form-control" id="parcelas">
            </div>

            <button type="submit" class="btn btn-lg btn-primary">Calcular</button>
          </form>
        </div>
      </div>
      <div class="container">

        <%
          float taxaConvertida = (taxa / 12) / 100;

          float amortizacao = 0;
          float juros = 0;
          float parcelafixa = (float) (saldodevedor * (Math.pow(1 + taxaConvertida, parcelas) * taxaConvertida) / (Math.pow(1 + (taxaConvertida), parcelas) - 1));

          float totalSaldoDevedor = 0;
          float totalJuros = 0;
          float totalAmortizacao = 0;
          float totalParcelas = 0;

         

        %>
        <table class="table border">
          <thead class="thead-dark">
            <tr>
              <th scope="col">Mês</th>
              <th scope="col">Saldo devedor</th>
              <th scope="col">Juros</th>
              <th scope="col">Amortização</th>
              <th scope="col">Parcela</th>
            </tr>

          </thead>
          <tbody>
            <tr>
              <th scope="col">#</th>
              <td ><%= saldodevedor%></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
            <%
              for (int i = 1; i <= parcelas; i++) {
                totalSaldoDevedor += saldodevedor;

                juros = saldodevedor * taxaConvertida;
                amortizacao = parcelafixa - juros;
                saldodevedor -= amortizacao;

                totalJuros += juros;
                totalAmortizacao += amortizacao;
                totalParcelas += parcelafixa;

                float saldoArredondado = Math.round(saldodevedor);
            %>
            <tr>
              <th scope="row"><%= i%></th>
              <td><%= (i == parcelas ? saldoArredondado : df.format(saldodevedor))%></td>
              <td><%= df.format(juros)%></td>
              <td><%= df.format(amortizacao)%></td>
              <td><%= df.format(parcelafixa)%></td>
            </tr>
            <%}%>

            <tr class="bg-dark text-white">
              <th scope="row">TOTAIS</th>
              <td></td>
              <td><%= df.format(totalJuros)%></td>
              <td><%= df.format(Math.round(totalAmortizacao))%></td>
              <td><%= df.format(totalParcelas)%></td>
            </tr>
          </tbody>
        </table>
      </div>
    </main>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    <%@include file="WEB-INF/jspf/scripts.jspf" %>
  </body>
</html>

