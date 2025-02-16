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
import java.util.List;
import java.util.Map;
import model.D_Feedback;
import model.Hotel;
import model.Image;
import model.Thao_Room;

/**
 *
 * @author thanh
 */
@WebServlet(name = "HotelDetailServlet", urlPatterns = {"/hotel-detail"})
public class HotelDetailServlet extends HttpServlet {

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
        try {
            
            HttpSession session = request.getSession();
            int hotelId = Integer.parseInt(request.getParameter("id"));

            DAO dao = new DAO();
//            RoomDAO roomDAO = new RoomDAO();
//            ImageDAO imageDAO = new ImageDAO();

            Hotel hotel = dao.Thao_getHotelById(hotelId);

            if (hotel != null) {
                List<Thao_Room> rooms = dao.Thao_getRoomsByHotelId(hotelId);
                List<Image> hotelImages = dao.Thao_getImagesByHotelId(hotelId);

                // Tạo map để lưu ảnh đầu tiên của mỗi phòng
                Map<Integer, String> roomFirstImages = new HashMap<>();
                if (rooms != null) {
                    for (Thao_Room room : rooms) {
                        List<Image> roomImages = dao.Thao_getImagesByRoomId(room.getRoomId());
                        if (roomImages != null && !roomImages.isEmpty()) {
                            roomFirstImages.put(room.getRoomId(), roomImages.get(0).getLink());
                        }
                    }
                }

                request.setAttribute("hotel", hotel);
                request.setAttribute("rooms", rooms);
                request.setAttribute("hotelImages", hotelImages);
                request.setAttribute("roomFirstImages", roomFirstImages);
                Map<Integer, D_Feedback> listFeedBack = dao.D_getFeedbackList(); // Implement this method in your DAO
                request.setAttribute("listFeedBack", listFeedBack);

                request.getRequestDispatcher("hotel-detail.jsp").forward(request, response);
            } else {
                System.out.println("Hotel not found for ID: " + hotelId);
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            System.out.println("Error in HotelDetailServlet: " + e.getMessage());
            response.sendRedirect("error.jsp");
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
