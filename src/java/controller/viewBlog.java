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
import java.util.List;
import java.util.Map;
import model.Account;
import model.Blog;
import model.D_Feedback;
import model.Hotel;
import model.Room;
import model.Room_type;

/**
 *
 * @author Asus
 */
@WebServlet(name = "viewBlog", urlPatterns = {"/viewBlog"})
public class viewBlog extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            CheckValidation validation = new CheckValidation();
            int role_ID = 6;
            Account account = (Account) session.getAttribute("acc");
            if (account != null) {
                role_ID = account.getRole_ID();
            }

            int maxPage = 0;
            int cPage = 1;
            int bpPage = 5;
            String blogType = request.getParameter("blogType");
            DAO dao = new DAO();
            Map<Integer, Hotel> listHotels = dao.D_getHotelsList();

            if (blogType == null || (!blogType.equalsIgnoreCase("Guide") && !blogType.equalsIgnoreCase("News") && !blogType.equalsIgnoreCase("Review") && !blogType.equalsIgnoreCase("Promotion")&& !blogType.equalsIgnoreCase("About"))) {
                    blogType = "News";
            }
            if(role_ID==4&&blogType.equalsIgnoreCase("About")){
                
            }else{
                blogType = "News";
            }

            bpPage = validation.D_validationInt(request.getParameter("bpPage"), 5, 20);
            if (bpPage != 5 && bpPage != 10 && bpPage != 20) {
                bpPage = 5;
            }
            Map<Integer, Blog> listBlogs = dao.D_getBlogsByType(blogType);
            maxPage = listBlogs.size() / bpPage + 1;
            if (validation.D_validationInt(request.getParameter("cPage"), 1, maxPage) > -1) {
                cPage = Integer.parseInt(request.getParameter("cPage"));
            }

            request.setAttribute("bpPage", bpPage);
            request.setAttribute("cPage", cPage);
            request.setAttribute("maxPage", maxPage);
            request.setAttribute("blogType", blogType);
            request.setAttribute("listHotels", listHotels);
            request.setAttribute("listBlogs", listBlogs);
            request.getRequestDispatcher("viewBlog.jsp").forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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

}
