package com.ommart.register;

import java.io.IOException;
import java.sql.*;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import DB.dbcon;

/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();

		String uname = request.getParameter("luname");
		String password = request.getParameter("lpsw");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			PreparedStatement pst = con.prepareStatement("select * from user where uname = ? and password = ?");
			pst.setString(1, uname);
			pst.setString(2, password);
			/* pst.setString(3, "user"); */

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				session.setAttribute("name", rs.getString("uname"));
				session.setAttribute("role", rs.getString("role"));
				session.setAttribute("uid", rs.getInt("id"));

				if (rs.getString("role").equals("admin")) {
					/* dispatcher = request.getRequestDispatcher("admin/order.html"); */
					response.sendRedirect("admin/order.jsp");

				} else {
					/* dispatcher = request.getRequestDispatcher("index.jsp"); */
					response.sendRedirect("index.jsp");
				}
			} else {
				request.setAttribute("status", "failed");
				dispatcher = request.getRequestDispatcher("login.jsp");
			}

			dispatcher.forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

}
