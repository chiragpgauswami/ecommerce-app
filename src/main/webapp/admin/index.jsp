
<%
if (session.getAttribute("name") != null && session.getAttribute("role").equals("admin")) {
	response.sendRedirect("order.jsp");	
} else{
	response.sendRedirect("../login.jsp");
}
%>