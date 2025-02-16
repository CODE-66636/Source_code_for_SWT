<%-- 
    Document   : room
    Created on : Feb 10, 2025, 1:10:26 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="model.Account"%>
<%@page import="controller.Controller"%>
<%@page import="model.Room"%>
<%@page import="model.D_Feedback"%>
<%@page import="model.Room_type"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Blog"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.Hotel"%>
<!-- JSP Start -->
<%
    Account account = (Account) session.getAttribute("acc");
    int role_ID = 6;
    Map<Integer, Blog> listReview = (Map<Integer, Blog>) request.getAttribute("listReview");
    Map<Integer, D_Feedback> listFeedBack = (Map<Integer, D_Feedback>) request.getAttribute("listFeedBack");
    Controller controller = new Controller();
    if (account != null) {
        role_ID = account.getRole_ID();
    }
    
    List<Integer> keyFeedback = new ArrayList<>(listFeedBack.keySet());
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Hotelier - Hotel HTML Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">  

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <div class="container-xxl bg-white p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->

            <!-- Header Start -->
            <div class="container-fluid bg-dark px-0">
                <div class="row gx-0">
                    <div class="col-lg-3 bg-dark d-none d-lg-block">
                        <a href="home" class="navbar-brand w-100 h-100 m-0 p-0 d-flex align-items-center justify-content-center">
                            <h1 class="m-0 text-primary text-uppercase">Hotelier</h1>
                        </a>
                    </div>
                    <div class="col-lg-9">
                        <div class="row gx-0 bg-white d-none d-lg-flex">
                            <div class="col-lg-7 px-5 text-start">
                                <div class="h-100 d-inline-flex align-items-center py-2 me-4">
                                    <i class="fa fa-envelope text-primary me-2"></i>
                                    <p class="mb-0">
                                        <c:choose>
                                            <c:when test="${not empty hotelList}">
                                                ${hotelList[0].email}
                                            </c:when>
                                            <c:otherwise>
                                                Email not available
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                                <div class="h-100 d-inline-flex align-items-center py-2">
                                    <i class="fa fa-phone-alt text-primary me-2"></i>
                                    <p class="mb-0">
                                        <c:choose>
                                            <c:when test="${not empty hotelList}">
                                                ${hotelList[0].hotline}
                                            </c:when>
                                            <c:otherwise>
                                                Phone not available
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </div>
                            </div>
                            <div class="col-lg-5 px-5 text-end">
                                <div class="d-inline-flex align-items-center py-2">
                                    <a class="me-3" href=""><i class="fab fa-facebook-f"></i></a>
                                    <a class="me-3" href=""><i class="fab fa-twitter"></i></a>
                                    <a class="me-3" href=""><i class="fab fa-linkedin-in"></i></a>
                                    <a class="me-3" href=""><i class="fab fa-instagram"></i></a>
                                    <a class="" href=""><i class="fab fa-youtube"></i></a>
                                </div>
                            </div>
                        </div>
                        <nav class="navbar navbar-expand-lg bg-dark navbar-dark p-3 p-lg-0">
                            <a href="home" class="navbar-brand d-block d-lg-none">
                                <h1 class="m-0 text-primary text-uppercase">Hotelier</h1>
                            </a>
                            <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                                <div class="navbar-nav mr-auto py-0">
                                    <a href="home" class="nav-item nav-link active">Home</a>
                                    <a href="home" class="nav-item nav-link">Hotels</a>
                                    <a href="viewFeedback" class="nav-item nav-link">Feedback</a>
                                    <a href="home" class="nav-item nav-link">Blog</a>

                                </div>
                                <%if (role_ID == 6) {
                                %>
                                <div class="d-flex">
                                    <a href="login?tab=register" class="btn btn-secondary rounded-0 py-4 px-md-5 d-none d-lg-block">
                                        REGISTER
                                        <i class="fa fa-user ms-3"></i>
                                    </a>
                                    <a href="login" class="btn btn-primary rounded-0 py-4 px-md-5 d-none d-lg-block">
                                        LOGIN
                                        <i class="fa fa-user ms-3"></i>
                                    </a>
                                </div>
                                <%} else {%>
                                <div class="nav-item dropdown">
                                    <a href="" class="btn btn-primary rounded-0 py-4 px-md-5 d-none d-lg-block "><%= account.getUsername()%><i class="fa fa-user ms-3"></i></a>
                                    <div class="dropdown-menu rounded-0 m-0">
                                        <a href="logout" class="dropdown-item">LOG OUT</i></a>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- Header End -->


            <!-- Page Header Start -->
            <div class="container-fluid page-header mb-5 p-0" style="background-image: url(img/carousel-1.jpg);"> 
                <div class="container-fluid page-header-inner py-5">
                    <div class="container text-center pb-5">
                        <h1 class="display-3 text-white mb-3 animated slideInDown">Hotel</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb justify-content-center text-uppercase">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item"><a href="#">Pages</a></li>
                                <li class="breadcrumb-item text-white active" aria-current="page">Hotel</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->


            <!-- Booking Start -->
            <div class="container-fluid booking pb-5 wow fadeIn" data-wow-delay="0.1s">
                <div class="container">
                    <div class="bg-white shadow" style="padding: 35px;">
                        <div class="row g-2">
                            <div class="col-md-10">
                                <div class="row g-2">
                                    <div class="col-md-2">
                                        <select class="form-select" id="cityFilter" name="city">
                                            <option value="" ${empty selectedCity ? 'selected' : ''}>Select City</option>
                                            <option value="Hà Nội" ${selectedCity == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
                                            <option value="TP Hồ Chí Minh" ${selectedCity == 'TP Hồ Chí Minh' ? 'selected' : ''}>TP Hồ Chí Minh</option>
                                            <option value="Đà Nẵng" ${selectedCity == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
                                            <option value="Nha Trang" ${selectedCity == 'Nha Trang' ? 'selected' : ''}>Nha Trang</option>
                                            <option value="Hạ Long" ${selectedCity == 'Hạ Long' ? 'selected' : ''}>Hạ Long</option>
                                            <option value="Huế" ${selectedCity == 'Huế' ? 'selected' : ''}>Huế</option>
                                            <option value="Hội An" ${selectedCity == 'Hội An' ? 'selected' : ''}>Hội An</option>
                                            <option value="Đà Lạt" ${selectedCity == 'Đà Lạt' ? 'selected' : ''}>Đà Lạt</option>
                                            <option value="Sapa" ${selectedCity == 'Sapa' ? 'selected' : ''}>Sapa</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="date" id="date1" data-target-input="nearest">
                                            <input type="text" class="form-control datetimepicker-input"
                                                   placeholder="Check in" data-target="#date1" data-toggle="datetimepicker" />
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="date" id="date2" data-target-input="nearest">
                                            <input type="text" class="form-control datetimepicker-input" 
                                                   placeholder="Check out" data-target="#date2" data-toggle="datetimepicker"/>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select">
                                            <option selected>Adult</option>
                                            <option value="1">Adult 1</option>
                                            <option value="2">Adult 2</option>
                                            <option value="3">Adult 3</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select">
                                            <option selected>Child</option>
                                            <option value="1">Child 1</option>
                                            <option value="2">Child 2</option>
                                            <option value="3">Child 3</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-primary w-100" onclick="filterHotels()">Submit</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Booking End -->


            <!-- Room Start -->
            <div class="container-xxl py-5">
                <div class="container">
                    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                        <h6 class="section-title text-center text-primary text-uppercase">Our Hotels</h6>
                        <h1 class="mb-5">Explore Our <span class="text-primary text-uppercase">Hotels</span></h1>
                    </div>
                    <div class="row g-4">
                        <c:forEach items="${hotelList}" var="hotel">
                            <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                                <div class="room-item shadow rounded overflow-hidden">
                                    <div class="position-relative">
                                        <img class="img-fluid" 
                                             src="${firstImages[hotel.hotel_ID] != null ? firstImages[hotel.hotel_ID] : 'img/room-1.jpg'}" 
                                             alt="${hotel.name}"
                                             style="width: 100%; height: 250px; object-fit: cover;">
                                        <small class="position-absolute start-0 top-100 translate-middle-y bg-primary text-white rounded py-1 px-3 ms-4">Contact for Price</small>
                                    </div>
                                    <div class="p-4 mt-2">
                                        <div class="d-flex justify-content-between mb-3">
                                            <h5 class="mb-0">${hotel.name}</h5>
                                            <div class="ps-2">
                                                <small class="fa fa-star text-primary"></small>
                                                <small class="fa fa-star text-primary"></small>
                                                <small class="fa fa-star text-primary"></small>
                                                <small class="fa fa-star text-primary"></small>
                                                <small class="fa fa-star text-primary"></small>
                                            </div>
                                        </div>
                                        <div class="d-flex mb-3">
                                            <small class="border-end me-3 pe-3"><i class="fa fa-phone text-primary me-2"></i>${hotel.hotline}</small>
                                            <small><i class="fa fa-envelope text-primary me-2"></i>${hotel.email}</small>
                                        </div>
                                        <p class="text-body mb-3">${hotel.description}</p>
                                        <div class="d-flex justify-content-between">
                                            <a class="btn btn-sm btn-primary rounded py-2 px-4" href="hotel-detail?id=${hotel.hotel_ID}">View Detail</a>
                                            <a class="btn btn-sm btn-dark rounded py-2 px-4" href="booking?hotel=${hotel.hotel_ID}">Book Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- Room End -->


            <!-- Testimonial Start -->
            <div class="container-xxl testimonial my-5 py-5 bg-dark wow zoomIn" data-wow-delay="0.1s">
                <div class="container">
                    <div class="owl-carousel testimonial-carousel py-5">
                        <%
                            if (listFeedBack != null) {
                                int numOfFeedback = 0;
                                for (Integer key : listFeedBack.keySet()) {
                                    numOfFeedback++;
                                    if (numOfFeedback > 5) {
                                        break;
                                    }
                        %>
                        <div class="testimonial-item position-relative bg-white rounded overflow-hidden">
                            <i class="fa fa-quote-right fa-3x text-primary position-absolute end-0 bottom-0 me-4 mb-n1"></i>
                            <div class="d-flex align-items-center">
                                <i class="fa fa-user fa-2x text-primary mb-2"></i>
                                <div class="ps-3">
                                    <h6 class="fw-bold mb-1"><%= listFeedBack.get(key).getUsername()%></h6>
                                    <small><%= listFeedBack.get(key).getHotelname()%></small>
                                </div>
                            </div>
                            <div class="ps-2">
                                <small class="fa fa-star text-primary"></small>
                                <small class="fa fa-star text-primary"></small>
                                <small class="fa fa-star text-primary"></small>
                                <small class="fa fa-star text-primary"></small>
                                <small class="fa fa-star text-primary"></small>
                            </div>
                            <p><%= listFeedBack.get(key).getContent()%></p>
                        </div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
                <div class="col-lg-12 d-flex justify-content-end">
                    <a class="btn btn-sm btn-primary rounded py-2 px-4" href="viewFeedback">VIEW ALL FEEDBACK</a>
                </div>
            </div>
            <!-- Testimonial End -->
            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-light footer fadeIn d-flex align-items-start py-5" style="margin-top: 5px">
                <div class="container pb-5" >
                    <div class="row g-5 align-items-start justify-content-end" >

                        <div class="col-md-6 col-lg-3" ">
                            <c:choose>
                                <c:when test="${not empty hotelList}">
                                    <p class="mb-2">${hotelList[0].name}</p>
                                    <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>${hotelList[0].address}</p>
                                    <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>${hotelList[0].hotline}</p>
                                    <p class="mb-2"><i class="fa fa-envelope me-3"></i>${hotelList[0].email}</p>
                                    </c:when>
                                    <c:otherwise>
                                    <p class="mb-2">Hotel name not available</p>
                                    <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>Address not available</p>
                                    <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>Phone not available</p>
                                    <p class="mb-2"><i class="fa fa-envelope me-3"></i>Email not available</p>
                                </c:otherwise>
                            </c:choose>
                            <div class="d-flex pt-2">
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                                <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-5 col-md-12">
                            <div class="row gy-5 g-4">
                                <div class="col-md-6">
                                    <h6 class="section-title text-start text-primary text-uppercase mb-4">Company</h6>
                                    <a class="btn btn-link" href="">About Us</a>
                                    <a class="btn btn-link" href="">Contact Us</a>
                                    <a class="btn btn-link" href="">Privacy Policy</a>
                                    <a class="btn btn-link" href="">Terms & Condition</a>
                                    <a class="btn btn-link" href="">Support</a>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="section-title text-start text-primary text-uppercase mb-4">Services</h6>
                                    <a class="btn btn-link" href="">Food & Restaurant</a>
                                    <a class="btn btn-link" href="">Spa & Fitness</a>
                                    <a class="btn btn-link" href="">Sports & Gaming</a>
                                    <a class="btn btn-link" href="">Event & Party</a>
                                    <a class="btn btn-link" href="">GYM & Yoga</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Footer End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
    <script>
                                    function filterHotels() {
                                        var city = document.getElementById('cityFilter').value;
                                        window.location.href = 'hotel?city=' + encodeURIComponent(city);
                                    }


                                    document.addEventListener('DOMContentLoaded', function () {
                                        var selectedCity = '${selectedCity}';
                                        if (selectedCity) {
                                            document.getElementById('cityFilter').value = selectedCity;
                                        }
                                    });
    </script>

</html>
