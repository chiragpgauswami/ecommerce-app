
<%@page import="DB.dbcon"%>
<%
if (session.getAttribute("name") != null) {
%>

<%@page import="java.sql.*"%>
<%@ include file="/components/header.jsp"%>

<%
Connection con = null;
dbcon db = new dbcon();
try {
	Class.forName("com.mysql.jdbc.Driver");

	con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

	int uid = (int) session.getAttribute("uid");

	/* Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("select * from product"); */

	PreparedStatement pstpt = con.prepareStatement("select * from tblcart where customer_id= ? ");
	pstpt.setInt(1, uid);

	ResultSet rsts = pstpt.executeQuery();

	if (rsts.next()) {
%>

<div class="c-page">
	<div class="c-shopping-cart">
		<!-- Title -->
		<div class="c-title">Shopping Bags</div>


		<%
		PreparedStatement pst = con.prepareStatement(
				"select product.pimgname,product.pname,tblcart.quantity,tblcart.mrp_price,tblcart.id,tblcart.total_price,tblcart.product_id from product,tblcart where product.id=tblcart.product_id and customer_id= ? ");
		pst.setInt(1, uid);

		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
		%>

		<!-- Product #1 -->

		<form action="updateproductquantity" method="post">

			<div class="c-item">
				<input type="hidden" value="<%=rs.getInt("product_id")%>"
					name="productId">

				<div class="c-buttons">
					<span class="c-delete-btn"><a
						href="removeproductfromcart?productId=<%=rs.getInt("product_id")%>&cpId=<%=rs.getInt("id")%>"><i
							class="fa-solid fa-xmark"></i></a></span>
					<!-- <span class="c-like-btn"></span> -->
				</div>

				<div class="c-image">
					<img src="asset/img/<%=rs.getString("pimgname")%>" alt="" />
				</div>

				<div class="c-description">
					<span><%=rs.getString("pname")%></span>
				</div>

				<div class="c-quantity">
					<button class="c-plus-btn" type="button" name="button">
						<i class="fa-solid fa-plus"></i>
					</button>
					<input type="text" name="quantity"
						value="<%=rs.getInt("quantity")%>">
					<button type="submit" class="c-minus-btn" type="button"
						name="button">
						<i class="fa-solid fa-minus"></i>
					</button>
				</div>

				<div class="c-total-price">
					&#8377;<%=rs.getDouble("total_price")%></div>

				<div class="c-update-btn">
					<button class="c-ubutton">Update</button>
				</div>

			</div>

		</form>

		<%
		}

		PreparedStatement tpst = con
				.prepareStatement("select sum(total_price), sum(mrp_price) from tblcart where customer_id= ? ");
		tpst.setInt(1, uid);

		ResultSet trs = tpst.executeQuery();

		double finalBill = 0.0;
		/*  ResultSet totolAmount = DatabaseConnection.getResultFromSqlQuery("select sum(total_price), sum(mrp_price) from tblcart where customer_id='" + session.getAttribute("id") + "' "); */
		if (trs.next()) {
		finalBill = trs.getInt(1);
		}
		%>



		<div class="c-total">
			<h5 class="c-total-h">
				Total : &#8377;<%=finalBill%></h5>
			<form method="post" action="placeorder">
				<button type="submit" class="c-button">Place Order</button>
			</form>
		</div>
	</div>
</div>


<script>
	$('.c-minus-btn').on('click', function(e) {
		e.preventDefault();
		var $this = $(this);
		var $input = $this.closest('div').find('input');
		var value = parseInt($input.val());

		if (value > 1) {
			value = value - 1;
		} else {
			value = 1;
		}

		$input.val(value);

	});

	$('.c-plus-btn').on('click', function(e) {
		e.preventDefault();
		var $this = $(this);
		var $input = $this.closest('div').find('input');
		var value = parseInt($input.val());

		if (value < 100) {
			value = value + 1;
		} else {
			value = 100;
		}

		$input.val(value);
	});
</script>







<%
rs.close();
/* stmt.close(); */
con.close();

} else {
%>





<div class="c-page">


	<div class="ecart-card">
		<div class="card-body cart">
			<div class="empty-cart-cls">
				<img
					src="https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-3428238-2902697.png"
					class="img-fluid mb-4 mr-3">
				<h3>Your Cart is Empty</h3>
				<h4>Add something to make me happy :)</h4>
				<a href="index.jsp" data-abc="true"><button class="ec-button">Continue
						Shopping</button></a>


			</div>
		</div>
	</div>


</div>






<%
}
} catch (Exception e) {
e.printStackTrace();
}
%>



<%@ include file="/components/footer.jsp"%>



<%
} else {
response.sendRedirect("login.jsp");
}
%>