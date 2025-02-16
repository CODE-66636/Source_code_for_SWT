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
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import model.Account;
import model.Profile;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
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
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String phone = request.getParameter("phone");
        String userName = request.getParameter("userName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Date registrationDate = Date.valueOf(LocalDate.now());
        Timestamp lastLogin = new Timestamp(System.currentTimeMillis());
        Account acc = new Account(0, userName, password, registrationDate, lastLogin, "Active", email, 5);
        DAO dao = new DAO();
        CheckValidation valid = new CheckValidation();
        boolean usernameExists = dao.isUserNameExist(acc.getUsername());
        boolean emailExists = dao.isEmailExist(acc.getEmail());
        boolean validPhoneNumber = valid.isValidPhoneNumber(phone);
        if (usernameExists || emailExists || validPhoneNumber == false) {
            if (usernameExists) {
                request.setAttribute("regisError", "Username already exists!");
            }
            if (emailExists) {
                request.setAttribute("emailError", "Email already exists!");
            }
            if (validPhoneNumber == false) {
                request.setAttribute("phoneError", "Invalid phone number");
            }
            request.setAttribute("activeTab", "register");
            request.setAttribute("fname", firstName);
            request.setAttribute("lname", lastName);
            request.setAttribute("phone", phone);
            request.setAttribute("uname", userName);
            request.setAttribute("mail", email);
            request.setAttribute("pass", password);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            dao.registration(acc);
            Account temp = dao.getAccount(acc.getUsername(), acc.getPassword());
            Profile p = new Profile(0, firstName, lastName, phone, "Vietnam", email, temp.getAccount_ID(), 0);
            dao.addProfile(p);
            Account a = dao.getAccount(acc.getUsername(), acc.getPassword());
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(60 * 60);
            session.setAttribute("acc", a);
            response.sendRedirect("home");
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

}
