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
    
    // Initialize lists only if data is available
    List<Integer> keyNews = new ArrayList<>();
    List<Integer> keyHotels = new ArrayList<>();
    List<Integer> keyRoomType = new ArrayList<>();
    List<Integer> keyFeedback = new ArrayList<>();
    
    if (listHotels != null) {
        keyNews = new ArrayList<>(listHotels.keySet());
        keyHotels = new ArrayList<>(listHotels.keySet());
    }
    
    if (listRoomType != null) {
        keyRoomType = new ArrayList<>(listRoomType.keySet());
    }
    
    if (listFeedBack != null) {
        keyFeedback = new ArrayList<>(listFeedBack.keySet());
    }
%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Room Detail - ${hotel.name}</title>
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

        <style>
            /* Room Carousel Styles */
            .room-carousel {
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }

            .header-carousel .owl-carousel-item {
                position: relative;
                height: 500px;
            }

            .header-carousel .owl-carousel-item img {
                width: 100%;
                height: 100%;
                object-fit: contain;  /* Thay đổi từ cover sang contain */
                background-color: #f8f9fa;
            }

            /* Thumbnail Gallery */
            .thumbnail-gallery {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 10px;
                margin-top: 15px;
            }

            .thumbnail-item {
                aspect-ratio: 16/9;
                border-radius: 8px;
                overflow: hidden;
                cursor: pointer;
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .thumbnail-item.active {
                border-color: var(--primary);
            }

            .thumbnail-item:hover {
                border-color: var(--primary);
                opacity: 0.8;
            }

            .thumbnail-item img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            /* Feature Items */
            .feature-item {
                transition: all 0.3s ease;
            }

            .feature-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .feature-item i {
                font-size: 2rem;
            }

            /* Amenity Items */
            .amenity-item {
                transition: all 0.3s ease;
            }

            .amenity-item:hover {
                background-color: var(--light) !important;
                transform: translateX(5px);
            }

            /* Room Info Styles */
            .room-header {
                border-bottom: 1px solid #dee2e6;
                padding-bottom: 1rem;
            }

            .room-price h2 {
                font-size: 2.5rem;
                font-weight: 600;
            }

            /* Responsive Adjustments */
            @media (max-width: 991.98px) {
                .header-carousel .owl-carousel-item {
                    height: 400px;
                }
            }

            @media (max-width: 767.98px) {
                .thumbnail-gallery {
                    grid-template-columns: repeat(3, 1fr);
                }
            }
            body {
                padding-top: 0;
                padding-bottom: 0;
            }

            .container-xxl {
                position: relative;
                z-index: 1;
                background: white;
            }
            .footer {
                margin-top: 2rem;  /* Thêm khoảng cách giữa nội dung và footer */
            }

            .room-detail-section {
                margin-bottom: 100px;  /* Thêm khoảng cách phía dưới phần room detail */
                position: relative;
                z-index: 2;  /* Đảm bảo nội dung hiển thị trên footer */
            }

            .footer {
                position: relative;
                z-index: 1;  /* Đặt footer ở layer thấp hơn */
            }

            /* Chỉnh sửa style cho booking button */
            .booking-button-container {
                margin-bottom: 30px;
                position: relative;
                z-index: 2;
            }

            .btn-book-now {
                width: 100%;
                padding: 15px;
                font-size: 1.1rem;
                font-weight: 600;
            }
        </style>
    </head>

    <body>
        <div class="container-xxl bg-white p-0">
            <!-- Header Start -->
            <div class="container-fluid bg-dark px-0" style="position: relative; z-index: 100;">
                <div class="row gx-0">
                    <div class="col-lg-3 bg-dark d-none d-lg-block">
                        <a href="index.html" class="navbar-brand w-100 h-100 m-0 p-0 d-flex align-items-center justify-content-center">
                            <h1 class="m-0 text-primary text-uppercase">Hotelier</h1>
                        </a>
                    </div>
                    <div class="col-lg-9">
                        <div class="row gx-0 bg-white d-none d-lg-flex">
                            <div class="col-lg-7 px-5 text-start">
                                <div class="h-100 d-inline-flex align-items-center py-2 me-4">
                                    <i class="fa fa-envelope text-primary me-2"></i>
                                    <p class="mb-0">info@example.com</p>
                                </div>
                                <div class="h-100 d-inline-flex align-items-center py-2">
                                    <i class="fa fa-phone-alt text-primary me-2"></i>
                                    <p class="mb-0">+012 345 6789</p>
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
                            <a href="index.html" class="navbar-brand d-block d-lg-none">
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

            <!-- Page Header Start -->
            <div class="container-fluid page-header mb-5 p-0" style="background-image: url(img/carousel-1.jpg);">
                <div class="container-fluid page-header-inner py-5">
                    <div class="container text-center pb-5">
                        <h1 class="display-3 text-white mb-3 animated slideInDown">Room Details</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb justify-content-center text-uppercase">
                                <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
                                <li class="breadcrumb-item"><a href="hotel-detail?id=${hotel.hotel_ID}">${hotel.name}</a></li>
                                <li class="breadcrumb-item text-white active" aria-current="page">Room Detail</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <!-- Page Header End -->

            <!-- Room Detail Start -->
            <div class="container-xxl py-5 room-detail-section">
                <div class="container">
                    <!-- Room Content -->
                    <div class="row g-5">
                        <!-- Left Column - Room Images -->
                        <div class="col-lg-7">
                            <!-- Main Image Display -->
                            <div class="main-image-container mb-4">
                                <img id="mainImage" src="${not empty roomImages ? roomImages[0].link : 'img/room-1.jpg'}" 
                                     alt="Room Image" class="img-fluid w-100" style="height: 500px; object-fit: cover; border-radius: 15px;">
                            </div>

                            <!-- Thumbnails -->
                            <div class="thumbnail-gallery">
                                <c:forEach items="${roomImages}" var="image">
                                    <div class="thumbnail-item" onclick="updateMainImage('${image.link}')">
                                        <img src="${image.link}" alt="${image.imageName}">
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Right Column - Room Info -->
                        <div class="col-lg-5">
                            <!-- Room Title & Price -->
                            <div class="room-header mb-4">
                                <h1 class="display-6 mb-2">${room.name}</h1>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="room-type mb-3">
                                        <span class="badge bg-primary fs-6">${roomType.name}</span>
                                    </div>
                                    <div class="room-price text-end">
                                        <h2 class="text-primary mb-0">$${room.price}</h2>
                                        <small class="text-muted">per night</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Quick Info -->
                            <div class="room-features mb-4">
                                <div class="row g-3">
                                    <div class="col-6">
                                        <div class="feature-item p-3 text-center bg-light rounded">
                                            <i class="fa fa-bed text-primary mb-2"></i>
                                            <p class="mb-0">${room.bedQuantity} Beds</p>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="feature-item p-3 text-center bg-light rounded">
                                            <i class="fa fa-ruler-combined text-primary mb-2"></i>
                                            <p class="mb-0">${room.area}m²</p>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="feature-item p-3 text-center bg-light rounded">
                                            <i class="fa fa-users text-primary mb-2"></i>
                                            <p class="mb-0">Max ${room.quantity} Guests</p>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="feature-item p-3 text-center bg-light rounded">
                                            <i class="fa fa-star text-primary mb-2"></i>
                                            <p class="mb-0">${roomType.name}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Room Description -->
                            <div class="room-description mb-4">
                                <h4 class="mb-3">Description</h4>
                                <p class="text-muted">${room.description}</p>
                            </div>

                            <!-- Room Amenities -->
                            <div class="room-amenities">
                                <h4 class="mb-3">Amenities</h4>
                                <div class="row g-2">
                                    <c:forEach items="${roomAmenities}" var="amenity">
                                        <div class="col-6">
                                            <div class="amenity-item p-2 bg-light rounded">
                                                <i class="fa fa-check text-primary me-2"></i>
                                                <span>${amenity.name}</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Booking Button -->
                            <div class="booking-button-container mt-4">
                                <a href="#bookingForm" class="btn btn-primary btn-book-now py-3">Book Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Room Detail End -->

            <!-- Footer Start -->
                <div class="container-fluid bg-dark text-light footer fadeIn d-flex align-items-start py-5" style="margin-top: 5px">
                    <div class="container pb-5" >
                        <div class="row g-5 align-items-start justify-content-end" >

                            <div class="col-md-6 col-lg-3" ">
                                <h6 class="section-title text-start text-primary text-uppercase mb-4">Contact</h6>
                                <p class="mb-2">Grand Lotus Hanoi</p>
                                <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Hoàn Kiếm, Hà Nội</p>
                                <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>024-39876688</p>
                                <p class="mb-2"><i class="fa fa-envelope me-3"></i>hanoi@grandlotushotel.com</p>
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
                                        function updateMainImage(imageUrl) {
                                            document.getElementById('mainImage').src = imageUrl;

                                            // Remove active class from all thumbnails
                                            document.querySelectorAll('.thumbnail-item').forEach(item => {
                                                item.classList.remove('active');
                                            });

                                            // Add active class to clicked thumbnail
                                            event.currentTarget.classList.add('active');
                                        }
    </script>
</html>