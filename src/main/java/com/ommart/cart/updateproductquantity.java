package com.ommart.cart;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DB.dbcon;

/**
 * Servlet implementation class updateproductquantity
 */
@WebServlet("/updateproductquantity")
public class updateproductquantity extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();
		

		// Getting all the data from the user/cutomer
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		
		HttpSession session = request.getSession();
		String mrp_price = null;
		Double productPrice = 0.0;
		Connection con = null;
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());
			
			
			// Querying to database
			
			int uid = (int) session.getAttribute("uid");
			
			PreparedStatement pst = con.prepareStatement("select mrp_price from tblcart where customer_id = ? and product_id = ?");
			pst.setInt(1, uid);
			pst.setInt(2, productId);
			
			ResultSet rs = pst.executeQuery();
			
			
			while (rs.next()) {
				// Getting data
				mrp_price = rs.getString("mrp_price");
				// Converting into double from string
				productPrice = Double.parseDouble(mrp_price);
			}
			
			
			productPrice = productPrice * quantity;
			
			
			// Update Query for updating product quantity
			
			PreparedStatement pstm = con.prepareStatement("update tblcart set quantity= ? ,total_price= ?  where customer_id= ? and product_id= ?");
			pstm.setInt(1, quantity);
			pstm.setDouble(2, productPrice);
			pstm.setDouble(3, uid);
			pstm.setInt(4, productId);

			int rowCount = pstm.executeUpdate();
			
			
			// If cart of online shopping systemis sucessfully updated
			if (rowCount > 0) {
				// Sending response back to the user/customer.
				response.sendRedirect("cart.jsp");
				// If cart is not updated
			} else {
				// Sending response back to the user/customer.
				response.sendRedirect("cart.jsp");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
