

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>OM MART</title>
        
        <link rel="icon" 
              type="image/png" 
              href="/asset/img/ico.png">

        <!-- Boxicons CDN Link -->
        <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"
              rel="stylesheet" />
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
        <link rel="stylesheet" href="alert/dist/sweetalert.css">

        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <link rel="stylesheet" href="asset/style.css">
    </head>

    <body>

        <!-- Navbar -->
        <nav>
            <div class="menu-icon">
                <span class="fas fa-bars"></span>
            </div>

            <div class="logo">
                <a href="index.jsp"> OM MART</a>
            </div>

            <%
                if (session.getAttribute("name") != null) {
                    if (session.getAttribute("role").equals("admin")) {
            %>


            <div class="search-icon">
                <a href="admin/index.jsp"><span class="fas fa-user"></span></a>
            </div>

            <%
            } else {
            %>

            <div class="search-icon">
                <a href="login.jsp"><span class="fas fa-user"></span></a>
            </div>


            <%
                }
            } else {
            %>



            <div class="search-icon">
                <a href="login.jsp"><span class="fas fa-user"></span></a>
            </div>

            <%
                }
            %>





            <div class="cancel-icon">
                <span class="fas fa-times"></span>
            </div>

            <form action="search.jsp" method="post">
                <input type="search" name="svalue" class="search-data"
                       placeholder="Search" required>
                <button type="submit" class="fas fa-search"></button>
            </form>

            <div class="nav-items">


                <%
                    if (session.getAttribute("name") != null) {
                %>

                <a href="yourorders.jsp"><button class="nav-btn">
                        <i class="fa-solid fa-box"></i> &nbsp; Orders
                    </button></a> 

                <%
                    if (session.getAttribute("role").equals("admin")) {
                %>


                <a href="admin/index.jsp"><button class="nav-btn">
                        <i class="fa-solid fa-user"></i> &nbsp; My Account
                    </button></a> <a href="logout"><button class="nav-btn">
                        <i class="fa-solid fa-right-from-bracket"></i>
                    </button></a>

                <%
                } else {
                %>


                <!-- <a href="login.jsp"><button class="nav-btn">
                                <i class="fa-solid fa-user"></i> &nbsp; My Account
                        </button></a>  -->

                <a href="logout"><button class="nav-btn">
                        <i class="fa-solid fa-right-from-bracket"></i>
                    </button></a>


                <%
                    }
                } else {
                %>
                <a href="login.jsp"><button class="nav-btn">
                        <i class="fa-solid fa-user"></i> &nbsp; Log In
                    </button></a>


                <%
                    }
                %>

                <!-- <button class="nav-btn"><a href="/login.jsp"><i class="fa-solid fa-user"></i> &nbsp; Register</a></button> -->
                <a href="cart.jsp"><button class="nav-btn">
                        <i class="fa-solid fa-cart-arrow-down"></i> &nbsp; Cart
                    </button></a>
            </div>
        </nav>