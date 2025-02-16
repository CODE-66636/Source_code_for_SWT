<%@page import="Validation.CheckValidation"%>
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
    Map<Integer, Hotel> listHotels = (Map<Integer, Hotel>) request.getAttribute("listHotels");
    Map<Integer, Blog> listBlogs = (Map<Integer, Blog>) request.getAttribute("listBlogs");
    Map<Integer, Blog> listSubContent = (Map<Integer, Blog>) request.getAttribute("listSubContent");
    Account account = (Account) session.getAttribute("acc");
    Controller controller = new Controller();
    int role_ID = 6;
    if (account != null) {
        role_ID = account.getRole_ID();
    }
    CheckValidation validation = new CheckValidation();

    int blog_ID = validation.D_validationInt(request.getAttribute("blog_ID") + "", 0, Integer.MAX_VALUE);

    if (listBlogs == null) {
        response.sendRedirect("viewBlog");
    } else {
        List<Integer> subContentKeys = new ArrayList();
        if (listSubContent != null) {
            subContentKeys = new ArrayList<>(listSubContent.keySet());
        }
        List<Integer> keyHotels = new ArrayList<>(listHotels.keySet());
        List<Integer> keyBlogs = new ArrayList<>(listBlogs.keySet());


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
                                    <p class="mb-0">  <%= listHotels.get(keyHotels.get(0)).getEmail()%>  </p> <!-- get email of first hotel-->
                                </div>
                                <div class="h-100 d-inline-flex align-items-center py-2">
                                    <i class="fa fa-phone-alt text-primary me-2"></i>
                                    <p class="mb-0"> <%= listHotels.get(keyHotels.get(0)).getHotline()%>  </p> <!-- get hotline of first hotel-->
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


            <!-- Blog Detail Start -->
            <div class="border-primary mt-4" >
                <%if (role_ID == 4) {
                %>
                <div class="d-flex">
                    <a href="" class="btn btn-primary rounded-0 py-4 px-md-5 d-none d-lg-block">
                        EDIT BLOG CONTENT
                    </a>
                </div>
                <%}%>
                <h1 class="text-primary " > <%= listBlogs.get(blog_ID).getTitle()%> </h1>
                <h6 style="margin-left: 15px"> <%= listBlogs.get(blog_ID).getPublication_date()%>  </h6>
                <div class="d-flex justify-content-center">
                    <img class="img-fluid" style="height: 400px;width: 700px" src="img/room-3.jpg" alt="">   
                </div>
                <p class="text-body mt-3" style=""><span style="text-indent: 2em; display: inline-block;">&nbsp;&nbsp;</span> <%= listBlogs.get(blog_ID).getContent()%>  </p>
                <%
                    for (Integer key : subContentKeys) {%>
                <div class="border-primary mt-4">
                    <h6 class="text-primary " style="margin-left: 20px"> <%= listSubContent.get(key).getTitle()%> </h6>
                    <div class="d-flex justify-content-center">
                        <img class="img-fluid" style="height: 400px;width: 700px" src="img/room-3.jpg" alt="">   
                    </div>
                    <p class="text-body mt-3" style=""><span style="text-indent: 2em; display: inline-block;">&nbsp;&nbsp;</span> <%= listSubContent.get(key).getContent()%>  </p>
                </div>
                <%}%>
            </div>
            <!-- Blog Detail End -->     


            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-light footer fadeIn d-flex align-items-start py-5" style="margin-top: 5px">
                <div class="container pb-5" >
                    <div class="row g-5 align-items-start justify-content-end" >

                        <div class="col-md-6 col-lg-3" ">
                            <h6 class="section-title text-start text-primary text-uppercase mb-4">Contact</h6>
                            <p class="mb-2"><%= listHotels.get(1).getName()%></p>
                            <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i><%= listHotels.get(1).getAddress()%></p>
                            <p class="mb-2"><i class="fa fa-phone-alt me-3"></i><%= listHotels.get(1).getHotline()%></p>
                            <p class="mb-2"><i class="fa fa-envelope me-3 numberDropdown"></i><%= listHotels.get(1).getEmail()%></p>
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
                                    <h6 class=" section-title text-start text-primary text-uppercase mb-4">Company</h6>
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