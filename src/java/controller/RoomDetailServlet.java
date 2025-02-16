
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
import java.util.List;
import model.Amenity;
import model.Hotel;
import model.Image;
import model.Room_type;
import model.Thao_Room;

/**
 *
 * @author thanh
 */
@WebServlet(name = "RoomDetailServlet", urlPatterns = {"/room-detail"})
public class RoomDetailServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");

        try {
            HttpSession session = request.getSession();
            // Lấy room_id từ parameter
            String roomIdStr = request.getParameter("room_id");
            if (roomIdStr == null || roomIdStr.trim().isEmpty()) {
                response.sendRedirect("home"); // Chuyển về trang chủ nếu không có room_id
                return;
            }

            int roomId = Integer.parseInt(roomIdStr);

            // Khởi tạo các DAO cần thiết
//            RoomDAO roomDAO = new RoomDAO();
//            HotelDAO hotelDAO = new HotelDAO();
//            ImageDAO imageDAO = new ImageDAO();
//            AmenityDAO amenityDAO = new AmenityDAO();
//            RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
            DAO dao = new DAO();

            // Lấy thông tin phòng
            Thao_Room room = dao.Thao_getRoomById(roomId);
            if (room == null) {
                response.sendRedirect("error.jsp"); // Chuyển đến trang lỗi nếu không tìm thấy phòng
                return;
            }

            // Lấy thông tin khách sạn
            Hotel hotel = dao.Thao_getHotelById(room.getHotelId());

            // Lấy danh sách ảnh của phòng
            List<Image> roomImages = dao.Thao_getImagesByRoomId(roomId);
            System.out.println("Number of images found: " + roomImages.size()); // Debug log

            // Lấy danh sách tiện nghi của phòng
            List<Amenity> roomAmenities = dao.Thao_getAmenitiesByRoomId(roomId);

            // Lấy loại phòng
            Room_type roomType = dao.Thao_getRoomTypeByRoomId(roomId);

            // Set các attribute để hiển thị trong JSP
            request.setAttribute("room", room);
            request.setAttribute("hotel", hotel);
            request.setAttribute("roomImages", roomImages);
            request.setAttribute("roomAmenities", roomAmenities);
            request.setAttribute("roomType", roomType);

            // Thêm các thông tin bổ sung nếu cần
            // Ví dụ: các phòng tương tự, đánh giá, etc.
            List<Thao_Room> similarRooms = dao.Thao_getSimilarRooms(roomId, hotel.getHotel_ID());
            request.setAttribute("similarRooms", similarRooms);

            // Forward đến trang JSP
            request.getRequestDispatcher("room-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("Error parsing room ID: " + e.getMessage());
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            System.out.println("Error in RoomDetailServlet: " + e.getMessage());
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
