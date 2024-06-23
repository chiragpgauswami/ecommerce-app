<%@page import="DB.dbcon"%>
<%@page import="java.sql.*"%>
<%    if (session.getAttribute("name") != null && session.getAttribute("role").equals("admin")) {
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>PRODUCT - OM MART</title>
        
        <link rel="icon" 
              type="image/png" 
              href="/asset/img/ico.png">

        <!-- Boxicons CDN Link -->
        <link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"
              rel="stylesheet" />
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">

        <script
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <link rel="stylesheet" href="assets/style.css" />
    </head>

    <body>



        <%
            Connection con = null;
            dbcon db = new dbcon();
            try {
                Class.forName("com.mysql.jdbc.Driver");

                con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("select * from product");
        %>



        <div class="sidebar">
            <div class="logo_content">
                <a href="../index.jsp">
                    <div class="logo">
                        <div class="logo_name">OM MART</div>
                    </div>
                </a> <i class="bx bx-menu" id="btn"></i>
            </div>
            <ul class="nav_list">
                <li><a href="order.jsp"> <i class="bx bx-cart-alt"></i> <span
                            class="links_name">Order</span>
                    </a> <span class="tooltip">Order</span></li>
                <li><a href="products.jsp" class="nav-active"> <i
                            class="bx bx-grid-alt"></i> <span class="links_name">Products</span>
                    </a> <span class="tooltip">Products</span></li>
                <li><a href="add-admin.jsp"> <i class="bx bx-user"></i> <span
                            class="links_name">Add Admin</span>
                    </a> <span class="tooltip">Add Admin</span></li>
            </ul>
            <div class="content">
                <div class="user">
                    <div class="user_details">
                        <img src="assets/img/user.png" alt="" />
                        <div class="name_job">
                            <div class="name"><%=session.getAttribute("name")%></div>
                            <div class="job">Admin</div>
                        </div>
                    </div>
                    <a href="../logout"><i class="bx bx-log-out" id="log_out"></i></a>
                </div>
            </div>
        </div>



        <div class="home_content">
            <section id="home">
                <div class="inline-container">
                    <h3 class="d-heading">Product</h3>
                    <a href="add-product.jsp"><button class="add-btn">Add
                            Product</button></a>
                </div>

                <div class="out-table">
                    <table>
                        <tr>
                            <th>ID</th>
                            <th><i class="fa-solid fa-image"></i></th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>


                        <%
                            int inc = 1;
                            while (rs.next()) {
                        %>



                        <tr>
                            <td><%=inc%></td>
                            <td><img src="../asset/img/<%=rs.getString("pimgname")%>"
                                     alt=""></td>
                            <td><%=rs.getString("pname")%></td>
                            <td>&#8377;<%=rs.getDouble("price")%></td>
                            <td>

                                <!-- 	<button class="edit">
                                                        <i class="fa-solid fa-pen-to-square"></i>
                                                </button> -->

                                <a href="../productdelete?id=<%=rs.getInt("id")%>"><button
                                        class="delete">
                                        <i class="fa-solid fa-trash-can"></i>
                                    </button> </a></td>
                        </tr>



                        <%
                                    inc++;

                                }
                                rs.close();
                                stmt.close();
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>



                    </table>
                </div>
            </section>
        </div>

        <script src="assets/index.js"></script>
    </body>

</html>


<%
    } else {
        response.sendRedirect("../login.jsp");
    }

%>