/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AmenitiesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Amenities;

/**
 *
 * @author HP
 */
@WebServlet(name = "AmenitiesController", urlPatterns = {"/manage-amenitiesamenities"})
public class AmenitiesController extends HttpServlet {

    private AmenitiesDAO amenitiesDAO = new AmenitiesDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String pageStr = request.getParameter("page");

        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int recordsPerPage = 5;

        AmenitiesDAO dao = new AmenitiesDAO();
        List<Amenities> list;
        int totalRecords;

        if (search != null && !search.trim().isEmpty()) {
            list = dao.searchAmenities(search);
            totalRecords = list.size();
        } else {
            list = dao.getAllAmenities();
            totalRecords = list.size();
        }

        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        int start = (page - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);

        List<Amenities> paginatedList = list.subList(start, end);

        request.setAttribute("search", search);
        request.setAttribute("paginatedList", paginatedList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("amenities.jsp").forward(request, response);
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
