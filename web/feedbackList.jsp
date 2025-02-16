<%-- 
    Document   : feedbackList
    Created on : Feb 10, 2025, 7:10:58 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Feedback List</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="mb-3">Feedback List</h2>

            <form class="mb-3" method="get"  action="manage-feedbacks">
                <input type="text" name="search" value="${search}" class="form-control w-25 d-inline" placeholder="Search feedback...">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>

            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Rate</th>
                        <th>Content</th>
                        <th>Username</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="feedback" items="${feedbacks}">
                        <tr>
                            <td>${feedback.feedbackID}</td>
                            <td>${feedback.rate}</td>
                            <td>${feedback.content}</td>
                            <td>${feedback.username}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <nav>
                <ul class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&search=${search}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
    </body>
</html>