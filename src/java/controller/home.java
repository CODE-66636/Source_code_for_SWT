/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import model.Account;
import model.Blog;
import model.D_Feedback;
import model.Hotel;
import model.Room;
import model.Room_type;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Asus
 */
@WebServlet(name="home", urlPatterns={"/home"})
public class home extends HttpServlet {
   
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
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            
            DAO dao = new DAO();
            Map<Integer,Hotel> listHotels = dao.D_getHotelsList();
            Map<Integer,Blog> listAbout = dao.D_getBlogsByType("About");
            Map<Integer,Blog> listNews = dao.D_getBlogsByType("News");
            Map<Integer,Blog> listReview = dao.D_getBlogsByType("Review");
            Map<Integer,Blog> listGuide = dao.D_getBlogsByType("Guide");
            Map<Integer, Room_type> listRoomType = dao.D_getRoomTypeList();
            Map<Integer, D_Feedback> listFeedBack = dao.D_getFeedbackList();
            Map<Integer, List<Room>> ListRoomOfHotels = dao.D_getRoomOfHotel();
            
            
            request.setAttribute("listHotels", listHotels);
            request.setAttribute("listAbout", listAbout);
            request.setAttribute("listNews", listNews);
            request.setAttribute("listReview", listReview);
            request.setAttribute("listGuide", listGuide);
            request.setAttribute("listRoomType", listRoomType);
            request.setAttribute("listFeedBack", listFeedBack);
            request.setAttribute("ListRoomOfHotels", ListRoomOfHotels);
            request.getRequestDispatcher("home.jsp").forward(request, response);
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
