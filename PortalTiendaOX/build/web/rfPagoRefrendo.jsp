<%-- 
    Document   : rfPagoRefrendo
    Created on : 30/07/2018, 10:02:13 PM
    Author     : julio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>      
    <head>

       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <style>
            .linea 
            {	            
                    width:98%; 
                    color:#FAFAFA;
            }  
                        .lbltitulo
            {
                text-align: center;
                font-size:medium;
                color:#605D5C; 
                font-weight:bold;
            }
                        form {
              /* Just to center the form on the page */
              margin: 0 auto;
              width: 1000px;

              /* To see the limits of the form */
              padding: 1em;
              border: 1px solid #CCC;
              border-radius: 1em;
            }

            div + div {
              margin-top: 1em;
            }

            label {
              /* To make sure that all label have the same size and are properly align */
              display: inline-block;
              width: 90px;
              text-align: right;
            }

            input, textarea {
              /* To make sure that all text field have the same font settings
                 By default, textarea are set with a monospace font */
              font: 1em sans-serif;

              /* To give the same size to all text field */
              width: 300px;

              -moz-box-sizing: border-box;
                   box-sizing: border-box;

              /* To harmonize the look & feel of text field border */
              border: 1px solid #999;
            }

            input:focus, textarea:focus {
              /* To give a little highligh on active elements */
              border-color: #000;
            }

            .button {
              /* To position the buttons to the same position of the text fields */
              padding-left: 90px; /* same size as the label elements */
            }

            button {
              /* This extra magin represent the same space as the space between
                 the labels and their text fields */
              margin-left: .5em;
            }
        </style>   
        </head>
    <body>
        <table  width="98%">
            <tr align="center">
                <td class="lbltitulo">PAGO REFRENDO</td>    
            </tr>
        </table>        
        <form   action="/my-handling-form-page" method="post">                       
          <table>  
          <tr>
               <td>
                    <label for="Placas">Placas</label> 
                    <input  id="placas" name="placas">
                </td>
                <td>
                    <label for="pago">Pago</label> 
                    <input  id="pago" name="pago">
                </td>
          </tr>
          </table>  
         <hr class="linea"/>
         <table  width="98%"  >
            <tr align="center">
                <td>
                    <input type="submit" name="Guardar" value="Guardar"  
                           onclick= this.form.action="rfPagoRefrendo">
                 
                </td>
            </tr>
        </table>
        </form>
       
    </body>
</html>
