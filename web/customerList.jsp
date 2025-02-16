<%-- 
    Document   : customerList
    Created on : Feb 10, 2025, 1:21:28 PM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center">Customer Management</h2>

    <!-- Search Form -->
    <form class="d-flex mb-3" action="manage-customer" method="GET">
        <input type="text" name="search" class="form-control me-2" value="${search}" placeholder="Search customer...">
        <button class="btn btn-primary" type="submit">Search</button>
    </form>

    <!-- Customer Table -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Citizenship</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="customer" items="${customers}">
            <tr>
                <td>${customer.customerId}</td>
                <td>${customer.firstName} ${customer.lastName}</td>
                <td>${customer.phoneNumber}</td>
                <td>${customer.citizenship}</td>
                <td>${customer.email}</td>
                <td><a href="manage-customer?action=detail&id=${customer.customerId}" class="btn btn-info">Details</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Pagination -->
    <nav>
        <ul class="pagination">
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="manage-customer?page=${i}&search=${search}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>
</body>
</html>
