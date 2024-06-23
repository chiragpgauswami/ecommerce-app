package com.ommart.cart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DB.dbcon;

/**
 * Servlet implementation class removeproductfromcart
 */
@WebServlet("/removeproductfromcart")
public class removeproductfromcart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dbcon db = new dbcon();

		HttpSession session = request.getSession();
		Connection con = null;
		int productId = Integer.parseInt(request.getParameter("productId"));
		int cpid = Integer.parseInt(request.getParameter("cpId"));

		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			int uid = (int) session.getAttribute("uid");

			// Delete query for cart of particular id
			PreparedStatement pst = con.prepareStatement("delete from tblcart where id= ? and product_id= ? and customer_id= ? ");
			pst.setInt(1, cpid);
			pst.setInt(2, productId);
			pst.setInt(3, uid);

			int rowCount = pst.executeUpdate();

			if (rowCount > 0) {
				response.sendRedirect("cart.jsp");
			} else {
				response.sendRedirect("cart.jsp");
			}



		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
