
<%
if (session.getAttribute("name") != null && session.getAttribute("role").equals("admin")) {
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>OM Mart</title>
        
        <link rel="icon" 
              type="image/png" 
              href="/asset/img/ico.png">

<!-- Boxicons CDN Link -->
<link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"
	rel="stylesheet" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="assets/style.css" />
</head>

<body>
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
			<li><a href="add-admin.jsp" > <i
					class="bx bx-user"></i> <span class="links_name">Add Admin</span>
			</a> <span class="tooltip">Add Admin</span></li>
		</ul>
		<div class="content">
			<div class="user">
				<div class="user_details">
					<img src="assets/img/user.png" alt="" />
					<div class="name_job">
						<div class="name"><%= session.getAttribute("name") %></div>
						<div class="job">Admin</div>
					</div>
				</div>
				<a href="../logout"><i class="bx bx-log-out" id="log_out"></i></a>
			</div>
		</div>
	</div>
	<div class="home_content">
		<section class="single-add-product">
			<div class="add-product">
				<h3 class="d-heading">Add Product</h3>

				<form action="../addproduct" method="post" enctype="multipart/form-data" class="pa-pro-form">
					<div class="form-group p-grp">
						<label for="p-img">Product Image</label>
						<div class="drag-area">
							<header>Drag & Drop to Upload File</header>
							<span>OR</span>
							<button>Browse File</button>
						</div>
						
							<input id="upin" type="file" name="pimg" hidden>
					</div>
					<div class="form-group">
						<label for="pname">Product Name</label> <input type="text"
							name="pname">
					</div>
					<!-- <div class="form-group">
						<label for="pcat">Product Category</label> <input type="text"
							name="pcat">
					</div> -->
					<div class="form-group">
						<label for="price">Price</label> <input type="text" name="price">
					</div>
					<input type="submit" value="Publish">
				</form>
			</div>
		</section>
	</div>

	<script src="assets/index.js"></script>
</body>

</html>


<%
	
} else{
	response.sendRedirect("../login.jsp");
}
%>