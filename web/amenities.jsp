<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Amenities</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2 class="text-center">Amenities Management</h2>

    <!-- Search Form -->
    <form action="manage-amenities" method="get" class="mb-4 d-flex">
        <input type="text" name="search" class="form-control me-2" placeholder="Search amenities..." value="${param.search}">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <!-- List of Amenities -->
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="amenity" items="${paginatedList}">
            <tr>
                <td>${amenity.amenitiesID}</td>
                <td>${amenity.name}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Pagination -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="manage-amenities?page=${i}&search=${param.search}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
