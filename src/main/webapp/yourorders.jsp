
<%@page import="DB.dbcon"%>
<%
if (session.getAttribute("name") != null) {
%>

<%@page import="java.sql.*"%>
<%@ include file="/components/header.jsp"%>


<%
Connection con = null;
dbcon db = new dbcon();
String uname = (String) session.getAttribute("name");
try {
	Class.forName("com.mysql.jdbc.Driver");
	

	con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());
	Statement stmt = con.createStatement();
	PreparedStatement pst = con.prepareStatement("select * from tblorders where customer_name = ?");
	pst.setString(1, uname);
	
	ResultSet rs = pst.executeQuery();
%>

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
					<th>Qty</th>
					<th>Total Amount</th>
					<th>Status</th>
					<th>Order Date & Time</th>
				</tr>

				<%
				int incno = 0;
				while (rs.next()) {
					incno++;
				%>
				<tr>
					<td><%=incno%></td>

					<td><%=rs.getInt("order_no")%></td>

					<td><img src="asset/img/<%=rs.getString("image")%>" alt=""></td>

					<td><%=rs.getString("product_name")%></td>

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



<%@ include file="/components/footer.jsp"%>



<%
} else {
response.sendRedirect("login.jsp");
}
%>