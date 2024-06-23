package com.ommart.cart;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DB.dbcon;

/**
 * Servlet implementation class addtocart
 */
@WebServlet("/addtocart")
public class addtocart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();

		/* int id = 0; */
		// Getting all the parameters from the user
		HttpSession session = request.getSession();
		Connection con = null;
		int productId = Integer.parseInt(request.getParameter("productId"));
		Double mrp_price = Double.parseDouble(request.getParameter("mrp_price"));
		int customerId = (int) session.getAttribute("uid");
		int quantity;
		int oldqty = 0;
		Double productPrice = 0.0;

		/* String mrp_price = request.getParameter("mrp_price"); */
		int pqty = Integer.parseInt(request.getParameter("pqty"));

		try {

			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			// If user session is null user have to re-login
			if ((String) session.getAttribute("name") == null) {
				response.sendRedirect("login.jsp");
				// Inserting cart details to the database
			} else {

				PreparedStatement pstt = con
						.prepareStatement("select * from tblcart where customer_id = ? and product_id = ?");
				pstt.setInt(1, customerId);
				pstt.setInt(2, productId);

				ResultSet rs = pstt.executeQuery();

				if (rs.next()) {

					PreparedStatement pst = con.prepareStatement(
							"select mrp_price,quantity from tblcart where customer_id = ? and product_id = ?");
					pst.setInt(1, customerId);
					pst.setInt(2, productId);

					ResultSet rss = pst.executeQuery();

					while (rss.next()) {
						// Getting data
						oldqty = rss.getInt("quantity");
					}

					quantity = pqty + oldqty;

					productPrice = mrp_price * quantity;

					// Update Query for updating product quantity

					PreparedStatement pstm = con.prepareStatement(
							"update tblcart set quantity= ? ,total_price= ?  where customer_id= ? and product_id= ?");
					pstm.setInt(1, quantity);
					pstm.setDouble(2, productPrice);
					pstm.setDouble(3, customerId);
					pstm.setInt(4, productId);

					int rowCount = pstm.executeUpdate();

					// If cart of online shopping systemis sucessfully updated
					if (rowCount > 0) {
						// Sending response back to the user/customer.
						response.sendRedirect("index.jsp");
						// If cart is not updated
					} else {
						// Sending response back to the user/customer.
						response.sendRedirect("index.jsp");
					}

				}

				else {

					Double price = mrp_price * pqty;

					PreparedStatement pst = con.prepareStatement(
							"insert into tblcart(quantity, total_price, customer_id, product_id, mrp_price) values(?, ?, ?, ?, ?)");

					pst.setInt(1, pqty);
					pst.setDouble(2, price);
					pst.setInt(3, customerId);
					pst.setInt(4, productId);
					pst.setDouble(5, mrp_price);

					int rowCount = pst.executeUpdate();

					// Querying to the database.

					if (rowCount > 0) {
						response.sendRedirect("index.jsp");
					} else {
						response.sendRedirect("index.jsp");
					}
				}
			}
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
