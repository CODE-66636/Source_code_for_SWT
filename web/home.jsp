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
    Map<Integer, Hotel> listHotels = (Map<Integer, Hotel>) request.getAttribute("listHotels");
    Map<Integer, Blog> listAbout = (Map<Integer, Blog>) request.getAttribute("listAbout");
    Map<Integer, Blog> listNews = (Map<Integer, Blog>) request.getAttribute("listNews");
    Map<Integer, Blog> listReview = (Map<Integer, Blog>) request.getAttribute("listReview");
    Map<Integer, Blog> listGuide = (Map<Integer, Blog>) request.getAttribute("listGuide");
    Map<Integer, Room_type> listRoomType = (Map<Integer, Room_type>) request.getAttribute("listRoomType");
    Map<Integer, D_Feedback> listFeedBack = (Map<Integer, D_Feedback>) request.getAttribute("listFeedBack");
    Map<Integer, List<Room>> ListRoomOfHotels = (Map<Integer, List<Room>>) request.getAttribute("ListRoomOfHotels");
    Controller controller = new Controller();
    if (account != null) {
        role_ID = account.getRole_ID();
    }
    if (listHotels == null) {
        response.sendRedirect("home");
    } else {
        List<Integer> keyNews = new ArrayList<>(listHotels.keySet());
        List<Integer> keyHotels = new ArrayList<>(listHotels.keySet());
        List<Integer> keyRoomType = new ArrayList<>(listRoomType.keySet());
        List<Integer> keyFeedback = new ArrayList<>(listFeedBack.keySet());
%>
<!-- JSP End -->


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
                                        <%= !keyHotels.isEmpty() ? listHotels.get(keyHotels.get(0)).getEmail() : "Email not available" %>
                                    </p>
                                </div>
                                <div class="h-100 d-inline-flex align-items-center py-2">
                                    <i class="fa fa-phone-alt text-primary me-2"></i>
                                    <p class="mb-0">
                                        <%= !keyHotels.isEmpty() ? listHotels.get(keyHotels.get(0)).getHotline() : "Phone not available" %>
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
                                    <a href="hotel" class="nav-item nav-link">Hotels</a>
                                    <a href="viewFeedback" class="nav-item nav-link">Feedback</a>
                                    <a href="viewBlog" class="nav-item nav-link">Blog</a> 

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



            <!-- Carousel Start -->
            <div class="container-fluid p-0 mb-5">
                <div id="header-carousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img class="w-100" src="img/carousel-1.jpg" alt="Image">
                            <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                                <div class="p-3" style="max-width: 700px;">
                                    <h6 class="section-title text-white text-uppercase mb-3 animated slideInDown">Luxury Living</h6>
                                    <h1 class="display-3 text-white mb-4 animated slideInDown">Discover A Brand Luxurious Hotel</h1>
                                    <a href="" class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Our Hotels</a>
                                    <a href="" class="btn btn-light py-md-3 px-md-5 animated slideInRight">Our Rooms</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Carousel End -->



            <!-- About Start -->
            <div class="container-xxl py-5">
                <div class="container">
                    <div class="row g-5 align-items-center">
                        <div class="col-lg-6">
                            <h6 class="section-title text-start text-primary text-uppercase">About Us</h6>
                            <div class="col-lg-6">
                                <%
                                    if (listAbout == null || listAbout.isEmpty()) {
                                %> 
                                <h1 class="mb-4">There is no About Us content!</h1>  
                                <%
                                    } else {
                                        List<Integer> keyAbout = new ArrayList<Integer>(listAbout.keySet());
                                %>
                                <h1 class="mb-4"><%= listAbout.get(keyAbout.get(0)).getTitle()%></h1>
                                <p class="mb-4"><%= listAbout.get(keyAbout.get(0)).getContent()%></p>
                                <%}%>

                                <div class="row g-3 pb-4">
                                    <div class="col-sm-4 wow fadeIn" data-wow-delay="0.1s">
                                        <div class="border rounded p-1">
                                            <div class="border rounded text-center p-4">
                                                <i class="fa fa-hotel fa-2x text-primary mb-2"></i>
                                                <h2 class="mb-1" data-toggle="counter-up"><%=listHotels.size()%></h2>
                                                <p class="mb-0">Hotels</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 wow fadeIn" data-wow-delay="0.3s">
                                        <div class="border rounded p-1">
                                            <div class="border rounded text-center p-4">
                                                <i class="fa fa-bed fa-2x text-primary mb-2"></i>
                                                <h2 class="mb-1" data-toggle="counter-up"><%= listRoomType.size()%></h2>
                                                <p class="mb-0">Room type</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 wow fadeIn" data-wow-delay="0.5s">
                                        <div class="border rounded p-1">
                                            <div class="border rounded text-center p-4">
                                                <i class="fa fa-users fa-2x text-primary mb-2"></i>
                                                <h2 class="mb-1" data-toggle="counter-up"> <%=  listFeedBack.size()%> </h2>
                                                <p class="mb-0">Feedback</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="row g-3">
                                    <div class="col-6 text-end">
                                        <img class="img-fluid rounded w-75 wow zoomIn" data-wow-delay="0.1s" src="img/about-1.jpg" style="margin-top: 25%;">
                                    </div>
                                    <div class="col-6 text-start">
                                        <img class="img-fluid rounded w-100 wow zoomIn" data-wow-delay="0.3s" src="img/about-2.jpg">
                                    </div>
                                    <div class="col-6 text-end">
                                        <img class="img-fluid rounded w-50 wow zoomIn" data-wow-delay="0.5s" src="img/about-3.jpg">
                                    </div>
                                    <div class="col-6 text-start">
                                        <img class="img-fluid rounded w-75 wow zoomIn" data-wow-delay="0.7s" src="img/about-4.jpg">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- About End -->

            <!-- News Start -->
            <div class="container-xxl py-5">
                <div class="container">
                    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                        <h6 class="section-title text-center text-primary text-uppercase">News</h6>
                    </div>
                    <div class="row g-4">
                        <% int numOfNews = 0;
                            for (Integer key : listNews.keySet()) {
                                numOfNews++;
                                if (numOfNews > 3) {
                                    break;
                                }

                        %>

                        <div class="col-lg-4 col-md-6 wow fadeInUp" style="height: 100% "data-wow-delay="0.6s">
                            <div class="room-item shadow rounded overflow-hidden">
                                <div class="position-relative">
                                    <img class="img-fluid" src="img/room-3.jpg" alt="">
                                </div>
                                <div class="p-4 mt-2">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h5 class="mb-0"><%= listNews.get(key).getTitle()%></h5>
                                    </div>
                                    <div class="d-flex mb-3">
                                        <small class="border-end me-3 pe-3"><i class="fa fa-quote-right text-primary me-2"></i><%= listNews.get(key).getType()%></small>
                                        <small class="border-end me-3 pe-3"><i class="fa fa-linkedin-in text-primary me-2"></i><%= listNews.get(key).getPublication_date()%></small>
                                    </div>

                                    <p class="text-body mb-3" style="height: 80px"><%= listNews.get(key).getContent().substring(0, 100) + "..."%></p>
                                    <div class="d-flex justify-content-between">
                                        <a class="btn btn-sm btn-primary rounded py-2 px-4" href="">View Detail</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%}%>

                    </div>
                    <div class="col-lg-12 d-flex justify-content-end">
                        <a class="btn btn-sm btn-primary rounded py-2 px-4 wow fadeInUp" data-wow-delay="0.6s" style="margin-top: 10px" href="">VIEW ALL NEWS</a>
                    </div>
                </div>
            </div>
            <!-- News End -->


            <!-- Hotel Start -->
            <div class="container-xxl py-5">
                <div class="container">
                    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                        <h6 class="section-title text-center text-primary text-uppercase">Our Hotels</h6>
                        <h1 class="mb-5">Explore Our <span class="text-primary text-uppercase">Hotels</span></h1>
                    </div>
                    <div class="row g-4">
                        <% int numOfHotels = 0;
                            for (Integer key : listHotels.keySet()) {
                                numOfHotels++;
                                if (numOfHotels > 3) {
                                    break;
                                }

                        %>

                        <div class="col-lg-4 col-md-6 wow fadeInUp" style="height: 100% "data-wow-delay="0.6s">
                            <div class="room-item shadow rounded overflow-hidden">
                                <div class="position-relative">
                                    <img class="img-fluid" src="img/room-3.jpg" alt="">
                                    <small class="position-absolute start-0 top-100 translate-middle-y bg-primary text-white rounded py-1 px-3 ms-4">From <%= ListRoomOfHotels.get(key).get(0).getPrice()%> VND/night</small>
                                </div>
                                <div class="p-4 mt-2">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h5 class="mb-0"><%= listHotels.get(key).getName()%></h5>
                                    </div>
                                    <div>
                                        <p class=" me-3 pe-3"><%= listHotels.get(key).getAddress()%></p>
                                    </div>
                                    <div class="d-flex mb-3">
                                        <small class="border-end me-3 pe-3"><i class="fa fa-bed text-primary me-2"></i><%= ListRoomOfHotels.get(key).size()%> Types of room</small>
                                        <small class="border-end me-3 pe-3"><i class="fa fa-bath text-primary me-2"></i><%= controller.CountRoomOfHotel(ListRoomOfHotels.get(key))%> Rooms</small>
                                        <small><i class="fa fa-wifi text-primary me-2"></i>Wifi</small>
                                    </div>

                                    <p class="text-body mb-3" style="height: 80px"><%= listHotels.get(key).getDescription()%></p>
                                    <div class="d-flex justify-content-between">
                                        <a class="btn btn-sm btn-primary rounded py-2 px-4" href="">View Detail</a>
                                        <a class="btn btn-sm btn-dark rounded py-2 px-4" href="">Book Now</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%}%>

                    </div>
                    <div class="col-lg-12 d-flex justify-content-end">
                        <a class="btn btn-sm btn-primary rounded py-2 px-4 wow fadeInUp" data-wow-delay="0.6s" style="margin-top: 10px" href="">VIEW ALL HOTEL</a>
                    </div>
                </div>
            </div>
            <!-- Hotel End -->



            <!-- Feedback Start -->
            <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                <h6 class="section-title text-center text-primary text-uppercase">FEEDBACK</h6>
            </div>
            <!-- Rating Start -->



            <!-- Rating  End -->


            <!-- Testimonial Start -->
            <div class="container-xxl testimonial my-5 py-5 bg-dark wow zoomIn" data-wow-delay="0.1s">
                <div class="container">
                    <div class="owl-carousel testimonial-carousel py-5">
                        <%
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
                        <%}%>
                    </div>
                </div>
                <div class="col-lg-12 d-flex justify-content-end">
                    <a class="btn btn-sm btn-primary rounded py-2 px-4" href="viewFeedback">VIEW ALL FEEDBACK</a>
                </div>
            </div>
            <!-- Testimonial End -->
            <!-- Feedback End -->





            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-light footer fadeIn d-flex align-items-start py-5" style="margin-top: 5px">
                <div class="container pb-5" >
                    <div class="row g-5 align-items-start justify-content-end" >

                        <div class="col-md-6 col-lg-3" ">
                            <h6 class="section-title text-start text-primary text-uppercase mb-4">Contact</h6>
                            <p class="mb-2"><%= !keyHotels.isEmpty() ? listHotels.get(keyHotels.get(0)).getName() : "Hotel name not available" %></p>
                            <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i><%= !keyHotels.isEmpty() ? listHotels.get(keyHotels.get(0)).getAddress() : "Address not available" %></p>
                            <p class="mb-2"><i class="fa fa-phone-alt me-3"></i><%= !keyHotels.isEmpty() ? listHotels.get(keyHotels.get(0)).getHotline() : "Phone not available" %></p>
                            <p class="mb-2"><i class="fa fa-envelope me-3"></i><%= !keyHotels.isEmpty() ? listHotels.get(keyHotels.get(0)).getEmail() : "Email not available" %></p>
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

</html>
<%}%>