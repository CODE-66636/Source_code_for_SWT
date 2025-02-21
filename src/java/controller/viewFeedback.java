/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Account;
import model.Blog;
import model.D_Feedback;
import model.Hotel;
import model.Room;
import model.Room_type;
import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.EOFException;
import java.util.List;
import java.util.Map;
import org.apache.el.util.Validation;
import Validation.CheckValidation;

/**
 *
 * @author Asus
 */
@WebServlet(name = "viewFeedback", urlPatterns = {"/viewFeedback"})
public class viewFeedback extends HttpServlet {

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
            int sr = 0;
            int maxPage = 0;
            int cPage = 1;
            Controller controller = new Controller();
            CheckValidation validation = new CheckValidation();
            DAO dao = new DAO();
            Map<Integer, Account> listAccount = dao.D_getAccountsList();
            Map<Integer, Hotel> listHotels = dao.D_getHotelsList();
            Map<Integer, Blog> listAbout = dao.D_getBlogsByType("About");
            Map<Integer, Blog> listNews = dao.D_getBlogsByType("News");
            Map<Integer, Blog> listReview = dao.D_getBlogsByType("Review");
            Map<Integer, Blog> listGuide = dao.D_getBlogsByType("Guide");
            Map<Integer, Room_type> listRoomType = dao.D_getRoomTypeList();
            Map<Integer, D_Feedback> listFeedBack = dao.D_getFeedbackList();
            Map<Integer, List<Room>> ListRoomOfHotels = dao.D_getRoomOfHotel();
            
            if(validation.D_validationInt(request.getParameter("sr"), 0, 5)>-1){
                sr=Integer.parseInt(request.getParameter("sr"));
            }
            List<Integer> listKey = controller.D_getFeedbackListByStarRate(sr, listFeedBack);
            maxPage = listKey.size() / 10+1;
            if(validation.D_validationInt(request.getParameter("cPage"), 1, maxPage)>-1){
                cPage = Integer.parseInt(request.getParameter("cPage"));
            }

            request.setAttribute("sr", sr);
            request.setAttribute("cPage", cPage);
            request.setAttribute("maxPage", maxPage);
            request.setAttribute("listHotels", listHotels);
            request.setAttribute("listAbout", listAbout);
            request.setAttribute("listNews", listNews);
            request.setAttribute("listReview", listReview);
            request.setAttribute("listGuide", listGuide);
            request.setAttribute("listRoomType", listRoomType);
            request.setAttribute("listFeedBack", listFeedBack);
            request.setAttribute("ListRoomOfHotels", ListRoomOfHotels);
            request.getRequestDispatcher("viewFeedback.jsp").forward(request, response);
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
