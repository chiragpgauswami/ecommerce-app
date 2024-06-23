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
 * Servlet implementation class updateorderstatus
 */
@WebServlet("/updateorderstatus")
public class updateorderstatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();

		int statusMode = 0;
		String orderId = request.getParameter("orderId");
		Connection con = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			// Taking input from admin order-id to get the order status from the database

			PreparedStatement pst = con.prepareStatement("select order_status from tblorders where order_no= ?");
			pst.setString(1, orderId);

			ResultSet rs = pst.executeQuery();

			while (rs.next()) {

				if (rs.getString("order_status").equals("Deliver")) {

					PreparedStatement pstm = con
							.prepareStatement("update tblorders set order_status='Pending' where order_no= ?");
					pstm.setString(1, orderId);

					statusMode = pstm.executeUpdate();

				} else {

					PreparedStatement pstm = con
							.prepareStatement("update tblorders set order_status='Deliver' where order_no= ?");
					pstm.setString(1, orderId);

					statusMode = pstm.executeUpdate();

				}
			}

			if (statusMode > 0) {
				// Sending response back to admin-all-orders.jsp page when sql query executed
				// sucesfully
				response.sendRedirect("admin/order.jsp");
			} else {
				// Sending response back to admin-all-orders.jsp page
				response.sendRedirect("admin/order.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
