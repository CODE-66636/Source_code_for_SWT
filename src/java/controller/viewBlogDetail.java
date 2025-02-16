/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import Validation.CheckValidation;
import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import model.Account;
import model.Blog;
import model.Hotel;

/**
 *
 * @author Asus
 */
@WebServlet(name="viewBlogDetail", urlPatterns={"/viewBlogDetail"})
public class viewBlogDetail extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            CheckValidation validation = new CheckValidation();
            int role_ID = 6;
            Account account = (Account) session.getAttribute("acc");
            if (account != null) {
                role_ID = account.getRole_ID();
            }

            int blog_ID=1;
            blog_ID=validation.D_validationInt(request.getParameter("blog_ID"), 0, Integer.MAX_VALUE);
            
            DAO dao = new DAO();
            Map<Integer, Blog> listSubContent= dao.D_getSubContent(blog_ID);
            
            Map<Integer, Hotel> listHotels = dao.D_getHotelsList();
            Map<Integer, Blog> listBlogs= dao.D_getBlogList();

            

            

            request.setAttribute("listBlogs", listBlogs);
            request.setAttribute("listHotels", listHotels);
            request.setAttribute("blog_ID", blog_ID);
            request.setAttribute("listSubContent", listSubContent);
            request.getRequestDispatcher("viewBlogDetail.jsp").forward(request, response);
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
