package com.ommart.order;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.dbcon;

import javax.servlet.http.*;

/**
 * Servlet implementation class placeorder
 */
@WebServlet("/placeorder")
public class placeorder extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();
		// Creating Session
		HttpSession session = request.getSession();
		int order_no = 1000;
		int orderProducts = 0;
		// Getting all the parameters from the user

		String customerName = (String) session.getAttribute("name");
		int uid = (int) session.getAttribute("uid");

		String product_name = null;
		int quantity = 0;
		String product_price = null;
		String product_total_price = null;
		String order_status = null;
		String pimgname = null;
		Connection con = null;



		try {

			Class.forName("com.mysql.jdbc.Driver");

			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			Statement rsMaxOrderNostmt = con.createStatement();

			// Getting maximium column of tblorders table
			ResultSet rsMaxOrderNo = rsMaxOrderNostmt.executeQuery("select max(order_no) from tblorders");

			if (rsMaxOrderNo.next()) {
				order_no = rsMaxOrderNo.getInt(1);
				order_no = 1000 + order_no;
			}

			// Getting all the orders from the database
			PreparedStatement totalProductpst = con.prepareStatement(
					"select product.pname,product.pimgname,tblcart.quantity,tblcart.mrp_price,tblcart.total_price,tblcart.product_id from product,tblcart where product.id=tblcart.product_id and customer_id= ?");
			totalProductpst.setInt(1, uid);

			ResultSet totalProduct = totalProductpst.executeQuery();

			while (totalProduct.next()) {
				order_no++;

				product_name = totalProduct.getString(1);
				quantity = totalProduct.getInt(3);
				product_price = totalProduct.getString(4);
				product_total_price = totalProduct.getString(5);
				pimgname = totalProduct.getString(2);
				order_status = "Pending";

				// Inserting product details inside the table

				PreparedStatement orderProductspst = con.prepareStatement(
						"insert into tblorders(order_no,customer_name,product_name,quantity,product_price,product_total_price,order_status,image) values(?,?,?,?,?,?,?,?)");
				orderProductspst.setInt(1, order_no);
				orderProductspst.setString(2, customerName);
				orderProductspst.setString(3, product_name);
				orderProductspst.setInt(4, quantity);
				orderProductspst.setString(5, product_price);
				orderProductspst.setString(6, product_total_price);
				orderProductspst.setString(7, order_status);
				orderProductspst.setString(8, pimgname);

				orderProducts = orderProductspst.executeUpdate();
			}

			PreparedStatement cartdeletepst = con.prepareStatement("delete from tblcart where customer_id= ?");
			cartdeletepst.setInt(1, uid);

			cartdeletepst.executeUpdate();

			if (orderProducts > 0) {
				// Sending response back to the user/customer
				String message = "Thank you for your order.";
				session.setAttribute("ordsuccess", message);
				response.sendRedirect("ordersuccess.jsp");
			} else {
				response.sendRedirect("cart.jsp");
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}

}
