
<%@page import="DB.dbcon"%>
<%@page import="java.sql.*"%>
<%
if (session.getAttribute("name") != null && session.getAttribute("role").equals("admin")) {
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ORDER - OM MART</title>
        
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
		ResultSet rs = stmt.executeQuery("select * from tblorders");
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
			<li><a href="order.jsp" class="nav-active"> <i
					class="bx bx-cart-alt"></i> <span class="links_name">Order</span>
			</a> <span class="tooltip">Order</span></li>
			<li><a href="products.jsp"> <i class="bx bx-grid-alt"></i> <span
					class="links_name">Products</span>
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
		<section id="order">
			<h3 class="d-heading">Orders</h3>

			<div class="out-table">
				<table>
					<tr>
						<th>#</th>
						<th>Order No</th>
						<th><i class="fa-solid fa-image"></i></th>
						<th>Product</th>
						<th>Customer Name</th>
						<th>Qty</th>
						<th>Total Amount</th>
						<th>Status</th>
						<th>Order Date & Time</th>
						<th>Action</th>
					</tr>

					<%
					int incno = 0;
					while (rs.next()) {
						incno++;
					%>
					<tr>
						<td><%=incno%></td>

						<td><%=rs.getInt("order_no")%></td>

						<td><img src="../asset/img/<%=rs.getString("image")%>" alt=""></td>

						<td><%=rs.getString("product_name")%></td>

						<td><%=rs.getString("customer_name")%></td>

						<td><%=rs.getString("quantity")%></td>

						<td><%=rs.getString("product_total_price")%></td>

						<%
						if (rs.getString("order_status").equals("Deliver")) {
						%>

						<td><span class="label label-success">Delivered</span></td>

						<%
						} else {
						%>

						<td><span class="label label-danger">Pending</span></td>

						<%
						}
						%>

						<td><%=rs.getString("order_date")%></td>


						<%
						if (rs.getString("order_status").equals("Deliver")) {
						%>

						<td><a
							href="../updateorderstatus?orderId=<%=rs.getInt("order_no")%>"><button
									class="edit">
									<i class="fa-solid fa-clock-rotate-left"></i>
								</button></a><a href="../deleteorder?orderId=<%=rs.getInt("order_no")%>"><button
									class="decline">
									<i class="fa-solid fa-xmark"></i>
								</button></a></td>

						<%
						} else {
						%>

						<td><a
							href="../updateorderstatus?orderId=<%=rs.getInt("order_no")%>"><button
									class="complate">
									<i class="fa-solid fa-check"></i>
								</button></a> <a href="../deleteorder?orderId=<%=rs.getInt("order_no")%>"><button
									class="decline">
									<i class="fa-solid fa-xmark"></i>
								</button></a></td>

						<%
						}
						%>
					</tr>
					<%
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