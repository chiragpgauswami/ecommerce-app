<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ORDER - OM MART</title>

<!-- Boxicons CDN Link -->
<link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="admin/assets/style.css" />
</head>

<body>
	<div class="sidebar">
		<div class="logo_content">
			<a href="/index.jsp">
				<div class="logo">
					<div class="logo_name">OM MART</div>
				</div>
			</a> <i class="bx bx-menu" id="btn"></i>
		</div>
		<ul class="nav_list">
			<li><a href="admin/order.jsp" class="nav-active"> <i
					class="bx bx-cart-alt"></i> <span class="links_name">Order</span>
			</a> <span class="tooltip">Order</span></li>
			<li><a href="admin/products.jsp"> <i
					class="bx bx-grid-alt"></i> <span class="links_name">Products</span>
			</a> <span class="tooltip">Products</span></li>
			<li><a href="admin/user.jsp"> <i class="bx bx-user"></i> <span
					class="links_name">User</span>
			</a> <span class="tooltip">User</span></li>
		</ul>
		<div class="content">
			<div class="user">
				<div class="user_details">
					<img src="admin/assets/img/user.png" alt="" />
					<div class="name_job">
						<div class="name">Chirag</div>
						<div class="job">Admin</div>
					</div>
				</div>
				<i class="bx bx-log-out" id="log_out"></i>
			</div>
		</div>
	</div>