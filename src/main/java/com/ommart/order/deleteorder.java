package com.ommart.order;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.dbcon;

/**
 * Servlet implementation class deleteorder
 */
@WebServlet("/deleteorder")
public class deleteorder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();

		String orderId = request.getParameter("orderId");
		Connection con = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			PreparedStatement pst = con.prepareStatement("delete from tblorders where order_no= ? ");
			pst.setString(1, orderId);

			int rowCount = pst.executeUpdate();

			if (rowCount > 0) {
				response.sendRedirect("admin/order.jsp");
			} else {
				response.sendRedirect("admin/order.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
