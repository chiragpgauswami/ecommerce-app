
<%@page import="DB.dbcon"%>
<%
String svalue = request.getParameter("svalue");

if (svalue.equals("")) {
	response.sendRedirect("index.jsp");
} else {
%>

<%@page import="java.sql.*"%>
<%@ include file="/components/header.jsp"%>

<%
Connection con = null;
dbcon db = new dbcon();
try {
	Class.forName("com.mysql.jdbc.Driver");

	con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT * FROM product WHERE pname LIKE '%" + svalue + "%'");
%>

<!-- Page Heading -->
<!-- <div class="p-heading"></div> -->
<div class="search-heading">
	<h3>Search Results</h3>
</div>


<!-- Products Grid -->
<div class="p-grid">

	<%
	while (rs.next()) {
	%>


	<form action="addtocart" method="post">
		<div class="card">
			<div class="card-img-top">
				<img src="asset/img/<%=rs.getString("pimgname")%>" alt="">
			</div>
			<div class="card-body">
				<h5 class="card-title"><%=rs.getString("pname")%></h5>
				<h5 class="card-price">
					&#8377;<%=rs.getDouble("price")%></h5>
				<div class=" btn-box">
					<div class="qty-btn">
						<div class="counter">
							<span class="down" onClick='decreaseCount(event, this)'>-</span>
							<input type="text" name="pqty" value="1"> <span
								class="up" onClick='increaseCount(event, this)'>+</span>
						</div>
					</div>




					<input type="hidden" name="productId" value="<%=rs.getInt("id")%>">
					<input type="hidden" name="mrp_price"
						value="<%=rs.getDouble("price")%>">


					<%
					if (session.getAttribute("name") != null) {
					%>

					<button class="card-btn" type="submit">
						<i class="fa-solid fa-cart-plus"></i> <span> &nbsp; Add To
							Cart</span>
					</button>


					<%
					} else {
					%>

					<a class="card-btn" onclick="location.href = 'login.jsp';"> <i
						class="fa-solid fa-cart-plus"></i> <span> &nbsp; Add To
							Cart</span>
					</a>


					<%
					}
					%>

				</div>
			</div>
		</div>

	</form>


	<%
	}
	rs.close();
	stmt.close();
	con.close();
	} catch (Exception e) {
	e.printStackTrace();
	}
	%>


</div>


<%@ include file="/components/footer.jsp"%>

<%
}
%>