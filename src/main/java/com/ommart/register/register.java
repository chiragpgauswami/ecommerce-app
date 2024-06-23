package com.ommart.register;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.dbcon;

/**
 * Servlet implementation class register
 */
@WebServlet("/register")
public class register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();

		String uname = request.getParameter("runame");
		String password = request.getParameter("rpsw");
		String role = request.getParameter("role");
		RequestDispatcher dispatcher = null;
		Connection con = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			PreparedStatement pst = con.prepareStatement("insert into user(uname,password,role) values(?,?,?)");
			pst.setString(1, uname);
			pst.setString(2, password);
			pst.setString(3, role);

			int rowCount = pst.executeUpdate();

			if (rowCount > 0) {

				if (role == "admin") {
					request.setAttribute("status", "rsuccess");
					response.sendRedirect("admin/add-admin.jsp");

				} else {
					request.setAttribute("status", "rsuccess");
					dispatcher = request.getRequestDispatcher("login.jsp");
					/* response.sendRedirect("login.jsp"); */
				}

			} else {

				request.setAttribute("status", "rfailed");

			}

			dispatcher.forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

}
