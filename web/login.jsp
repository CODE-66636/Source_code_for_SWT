<%-- 
    Document   : login
    Created on : Feb 9, 2025, 1:50:56 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login & Register</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/login.css"/>
    </head>
    <body>
        <% String activeTab = request.getParameter("tab");%>
        <div class="container mt-5">
            <ul class="nav nav-pills nav-justified mb-3" id="ex1" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link <%= (activeTab == null || !activeTab.equals("register")) ? "active" : ""%>" id="tab-login" data-bs-toggle="pill" href="#pills-login" role="tab"
                       aria-controls="pills-login" aria-selected="true">Login</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link <%= "register".equals(activeTab) ? "active" : ""%>" id="tab-register" data-bs-toggle="pill" href="#pills-register" role="tab"
                       aria-controls="pills-register" aria-selected="false">Register</a>
                </li>
            </ul>

            <div class="tab-content">
                <!-- Login Tab -->
                <div class="tab-pane fade <%= (activeTab == null || !activeTab.equals("register")) ? "show active" : ""%>" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
                    <form action="login" method="post">
                        <div class="text-center mb-3">
                            <p>Sign in with:</p>
                            <a href="your_facebook_login_url" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=707523446199-g07ubdoc2q304nb61i4qbn4kn687a58i.apps.googleusercontent.com&redirect_uri=http://localhost:8080/Project__SWP391/loginGoogle&scope=email%20profile&access_type=offline" 
                               class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-google"></i>
                            </a>
                            <a href="your_twitter_login_url" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-twitter"></i>
                            </a>
                        </div>
                        <p class="text-center">or:</p>
                        <!-- Username input -->
                        <div class="form-outline mb-4">
                            <input value="${not empty username ? username : cookie.uName.value}" name="username" class="form-control" required />
                            <label class="form-label">Username</label>
                        </div>
                        <!-- Password input -->
                        <div class="form-outline mb-4">
                            <input value="${not empty password ? password : cookie.uPass.value}" type="password" name="password" class="form-control" required />
                            <label class="form-label">Password</label>
                        </div>
                        <!-- Error message -->
                        <c:if test="${not empty loginError}">
                            <p style="color: red; text-align: center;">${loginError}</p>
                        </c:if>
                        <!-- Remember me & Forgot password -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div class="form-check">
                                <input ${not empty cookie.remem.value ? "checked" : ""} class="form-check-input" type="checkbox" id="rememberMe" name="remember">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <a href="#" class="text-decoration-none">Forgot password?</a>
                        </div>
                        <!-- Submit button -->
                        <button type="submit" class="btn btn-primary btn-block mb-4">Sign in</button>
                    </form>
                </div>

                <!-- Register Tab -->
                <div class="tab-pane fade <%= "register".equals(activeTab) ? "show active" : ""%>" id="pills-register" role="tabpanel" aria-labelledby="tab-register">
                    <form id="registerForm" action="register" method="post">
                        <div class="text-center mb-3">
                            <p>Sign up with:</p>
                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-facebook-f"></i>
                            </button>
                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-google"></i>
                            </button>
                            <button type="button" class="btn btn-link btn-floating mx-1">
                                <i class="fab fa-twitter"></i>
                            </button>
                        </div>
                        <p class="text-center">or:</p>
                        <!-- Name input -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-outline">
                                    <input value="${fname}" type="text" name="first_name" class="form-control" required />
                                    <label class="form-label">First name</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-outline">
                                    <input value="${lname}" type="text" name="last_name" class="form-control" required />
                                    <label class="form-label">Last name</label>
                                </div>
                            </div>
                        </div>
                        <!-- Phone number input -->
                        <div class="form-outline mb-4">
                            <input value="${phone}" type="text" name="phone" class="form-control" required />
                            <label class="form-label">Phone number</label>
                        </div>
                        <c:if test="${not empty phoneError}">
                            <p style="color: red; text-align: center;">${phoneError}</p>
                        </c:if>
                        <!-- Username input -->
                        <div class="form-outline mb-4">
                            <input value="${uname}" type="text" name="userName" class="form-control" required />
                            <label class="form-label">Username</label>
                        </div>
                        <c:if test="${not empty regisError}">
                            <p style="color: red; text-align: center;">${regisError}</p>
                        </c:if>
                        <!-- Email input -->
                        <div class="form-outline mb-4">
                            <input value="${mail}" type="email" name="email" class="form-control" required />
                            <label class="form-label">Email</label>
                        </div>
                        <c:if test="${not empty emailError}">
                            <p style="color: red; text-align: center;">${emailError}</p>
                        </c:if>
                        <!-- Password input -->
                        <div class="form-outline mb-4">
                            <input value="${pass}" id="password" type="password" name="password" class="form-control" required />
                            <label class="form-label">Password</label>
                        </div>
                        <!-- Confirm password input -->
                        <div class="form-outline mb-4">
                            <input value="${pass}" id="repeatPassword" type="password" name="password" class="form-control" required />
                            <label class="form-label">Confirm password</label>
                            <p id="error-message" style="color: red; font-size: 14px;"></p>
                        </div>
                        <!-- Terms & Conditions -->
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="terms" required>
                            <label class="form-check-label" for="terms">I have read and agree to the terms</label>
                        </div>
                        <!-- Submit button -->
                        <button type="submit" class="btn btn-primary btn-block mb-3">Sign up</button>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("registerForm");
                const password = document.getElementById("password");
                const repeatPassword = document.getElementById("repeatPassword");
                const errorMessage = document.getElementById("error-message");

                form.addEventListener("submit", function (event) {
                    if (password.value !== repeatPassword.value) {
                        event.preventDefault(); // Block form submission if password do not match
                        errorMessage.textContent = "Passwords do not match!";
                    } else {
                        errorMessage.textContent = ""; // Clear error if valid
                    }
                });
            });
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const activeTab = "${activeTab}"; // Nhận giá trị từ Servlet

                if (activeTab === "register") {
                    // Switch to the Register tab
                    document.getElementById("tab-register").classList.add("active");
                    document.getElementById("pills-register").classList.add("show", "active");
                    document.getElementById("tab-login").classList.remove("active");
                    document.getElementById("pills-login").classList.remove("show", "active");
                }
            });
        </script>
    </body>
</html>
