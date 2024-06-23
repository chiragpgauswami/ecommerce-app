
<%
if (session.getAttribute("name") == null) {
%>

<%@ include file="/components/header.jsp"%>

<input type="hidden" id="status"
	value="<%=request.getAttribute("status")%>">

<div class="l-main">
	<div class="wrapper">
		<div class="title-text">
			<div class="title login">Login Form</div>
			<div class="title signup">Signup Form</div>
		</div>
		<div class="form-container">
			<div class="slide-controls">
				<input type="radio" name="slide" id="login" checked> <input
					type="radio" name="slide" id="signup"> <label for="login"
					class="slide login">Login</label> <label for="signup"
					class="slide signup">Signup</label>
				<div class="slider-tab"></div>
			</div>
			<div class="form-inner">

				<!-- Login Form -->
				<form action="login" method="post" class="login">
					<div class="field">
						<input type="text" placeholder="Username" name="luname" required>
					</div>
					<div class="field">
						<input type="password" placeholder="Password" name="lpsw" required>
					</div>
					<div class="field btn">
						<div class="btn-layer"></div>
						<input type="submit" value="Login">
					</div>
					<div class="signup-link">
						Not a member? <a href="">Signup now</a>
					</div>
				</form>

				<!-- Register Form -->
				<form action="register" method="post" class="signup">
					<div class="field">
						<input type="text" placeholder="Username" name="runame" required>
					</div>
					<div class="field">
						<input type="password" placeholder="Password" name="rpsw" required>
						<input type="hidden" name="role" value="user">
					</div>
					<div class="field btn">
						<div class="btn-layer"></div>
						<input type="submit" value="Signup">
					</div>
				</form>

			</div>
		</div>
	</div>
</div>




<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

var status = document.querySelector("#status").value;

if (status == "rsuccess") {
	swal("Congrats","Account Created Successfully","success");
}else if(status == "rfailed"){
	swal("Sorry","Fail to Create Account","failed");
}
/* else if (status == "success") {
	swal("Congrats","Successfully Logged In","success");
} */
else if(status == "failed"){
	swal("Sorry","Wrong Username or Password","failed");
}

        const loginText = document.querySelector(".title-text .login");
        const loginForm = document.querySelector("form.login");
        const loginBtn = document.querySelector("label.login");
        const signupBtn = document.querySelector("label.signup");
        const signupLink = document.querySelector("form .signup-link a");
        signupBtn.onclick = (() => {
            loginForm.style.marginLeft = "-50%";
            loginText.style.marginLeft = "-50%";
        });
        loginBtn.onclick = (() => {
            loginForm.style.marginLeft = "0%";
            loginText.style.marginLeft = "0%";
        });
        signupLink.onclick = (() => {
            signupBtn.click();
            return false;
        });

    </script>

<%@ include file="/components/footer.jsp"%>


<%
} else {
response.sendRedirect("index.jsp");
}
%>