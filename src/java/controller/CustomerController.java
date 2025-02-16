/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author HP
 */
import dal.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CustomerInformation;
import java.io.IOException;
import java.util.List;

@WebServlet("/manage-customer")
public class CustomerController extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("detail".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            CustomerInformation customer = customerDAO.getCustomerById(id);
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customerDetail.jsp").forward(request, response);
        } else {
            int page = 1;
            int pageSize = 5;
            String search = request.getParameter("search") != null ? request.getParameter("search") : "";
            
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            List<CustomerInformation> customers = customerDAO.getCustomers(search, page, pageSize);
            int totalCustomers = customerDAO.getTotalCustomers(search);
            int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

            request.setAttribute("customers", customers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            
            request.getRequestDispatcher("customerList.jsp").forward(request, response);
        }
    }
}

