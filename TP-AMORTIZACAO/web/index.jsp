<%-- 
    Document   : index
    Created on : Sep 8, 2020, 9:32:40 PM
    Author     : Luan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <%@include file="WEB-INF/jspf/css.jspf" %>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Home - Amortização</title>
    
    <style>
      .content {
        height: 370px;
        display: flex;
        justify-content: space-between;
        flex-direction: column;
        align-items: center;
      }
    </style>
  </head>
  
  <body>
    <%@include file="WEB-INF/jspf/menu.jspf" %>
    
    <main role="main">
      <div class="jumbotron mt-5">
        <div class="container">
          <h1 class="display-4 font-weight-bold">Cálculo de amortização</h1>
          <p class="text-muted mt-3" style="font-size: 1.2rem; line-height: 35px;">Desenvolvido por
            <a href="https://github.com/jrmaciel131/" target="__blank">César Maciel</a>,
            <a href="https://github.com/guigran" target="__blank">Guilherme Teodoro</a>,
            <a href="https://github.com/LauroLds" target="__blank">Lauro Luiz</a> e
            <a href="https://github.com/luansilvae" target="__blank">Luan Silva</a>. 
            A aplicação realiza os calculos de amortização constante, americana e tabela price.</p>
        </div>
      </div>

      <div class="container mt-5">
        <div class="row">
          <div class="col-md-4 text-center content">
            <h3 class="mb-0">Amortização Constante</h3>
            <p class="mb-0">O sistema de amortização constante (SAC) é uma forma de amortização 
              de um empréstimo por prestações que incluem os juros, amortizando assim 
              partes iguais do valor total do empréstimo.
            </p>
            <p class="mb-0"><a class="btn btn-lg btn-primary mb-5" href="amortizacao-constante.jsp" role="button">Calcular &raquo;</a></p>
          </div>
          
          <div class="col-md-4 text-center content">
            <h3 class="mb-0">Amortização Americana</h3>
            <p class="mb-0">É um sistema de amortização de dívidas onde os juros de um empréstimo são pagos periodicamente, 
              porém a quitação do empréstimo se dá por meio de uma única parcela que deverá ser paga ao final do contrato.
            </p>
            <p class="mb-0"><a class="btn btn-lg btn-primary mb-5" href="amortizacao-americana.jsp" role="button">Calcular &raquo;</a></p>
          </div>
          
          <div class="col-md-4 text-center content">
            <h3 class="mb-0">Tabela Price</h3>
            <p class="mb-0">Tabela Price, também chamado de sistema francês de amortização, é um método usado 
              em amortização de empréstimo cuja principal característica é apresentar prestações (ou parcelas) iguais.
            </p>
            <p class="mb-0"><a class="btn btn-lg btn-primary mb-5" href="tabela-price.jsp" role="button">Calcular &raquo;</a></p>
          </div>
        </div>
      </div>
    </main>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
    <%@include file="WEB-INF/jspf/scripts.jspf" %>
  </body>
</html>
