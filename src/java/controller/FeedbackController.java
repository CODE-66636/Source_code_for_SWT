/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author HP
 */
import dal.FeedbackDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Feedback;

@WebServlet("/manage-feedbacks")
public class FeedbackController extends HttpServlet {

    private static final int PAGE_SIZE = 5;
    private FeedbackDAO feedbackDAO = new FeedbackDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {
            //Do not thing
        }

        int totalFeedbacks = feedbackDAO.getTotalFeedbacks(search);
        int totalPages = (int) Math.ceil((double) totalFeedbacks / PAGE_SIZE);
        List<Feedback> feedbacks = feedbackDAO.getFeedbacks(page, PAGE_SIZE, search);

        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);

        request.getRequestDispatcher("feedbackList.jsp").forward(request, response);
    }
}
