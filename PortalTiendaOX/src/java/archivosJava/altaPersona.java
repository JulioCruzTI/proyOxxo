/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package archivosJava;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.Respuesta;
/**
 *
 * @author julio
 */
@WebServlet(name = "altaPersona", urlPatterns = {"/altaPersona"})
public class altaPersona extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<div width='98%' align='center'>");
            out.println("<a href='ctlPersona.jsp'  align='center' title='Ir la página anterior'>REGRESAR..</a>");
            out.println("</div>");          
            out.println("</head>");
            out.println("<body>");
            
////         conexionPool mp = new conexionPool();                    
////         Connection con = mp.ds.getConnection();
                service.Cliente cleinte = new service.Cliente();
                
                cleinte.setNombre(request.getParameter("nombre"));
                cleinte.setApematerno(request.getParameter("amaterno")); 
                cleinte.setApepaterno(request.getParameter("apaterno"));
                cleinte.setIdproveedor(Integer.parseInt(request.getParameter("hide")));
                cleinte.setTelefono(request.getParameter("telefono"));
                
                Respuesta  res = insertaCliente(cleinte);
            
//            try {
//                Statement stm = con.createStatement();  
//                
//                String consulta;
//                if (request.getParameter("hide2")=="1" ){
//                    consulta=" execute sp_alta_cliente '" + request.getParameter("nombre") + "','" + request.getParameter("apaterno") + "','" + request.getParameter("amaterno") + "','" + request.getParameter("telefono") +"'," + request.getParameter("hide")+"," + "0";
//                }else{
//                    consulta=" execute SP_Alta_Refrendo '" + request.getParameter("nombre") + "','" + request.getParameter("apaterno") + "','" + request.getParameter("amaterno") + "','" + request.getParameter("telefono") +"'," + request.getParameter("placas")+"," + "0";
//                }
//                stm.executeUpdate(consulta);                
//                out.print("<p>registros guardados</p>");
//            }
//            
//            catch(SQLException ex ){
//             out.print("<p>El error es: " +  ex.getMessage()  + "</p>");
//            }                
                if (res.isSuccess()==true){
                    out.print("<p>registros guardados</p>");
                }else
                {
                    out.print("<p>"+ res.getMessage() +"</p>");
                }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(altaPersona.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(altaPersona.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private static Respuesta insertaCliente(service.Cliente cliente) {
        service.WSTelefonia_Service service = new service.WSTelefonia_Service();
        service.WSTelefonia port = service.getWSTelefoniaPort();
        return port.insertaCliente(cliente);
    }

}
