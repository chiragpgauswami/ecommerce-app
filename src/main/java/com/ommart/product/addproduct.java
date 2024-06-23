package com.ommart.product;

import java.io.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DB.dbcon;

/**
 * Servlet implementation class addproduct
 */

@MultipartConfig
@WebServlet("/addproduct/*")
public class addproduct extends HttpServlet {

	dbcon db = new dbcon();

	
	private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
		/* System.out.println("content-disposition header= "+contentDisp); */
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Part file = request.getPart("pimg");

		String imageFileName = getFileName(file);

		String uploadPath = "D:/JSP"+"/ommart/src/main/webapp/asset/img/" + imageFileName;

		String pname = request.getParameter("pname");
		String price = request.getParameter("price");
		RequestDispatcher dispatcher = null;
		Connection con = null;
		/*
		 * System.out.println(); System.out.println(imageFileName+" hiiiiii");
		 */

		try {

			FileOutputStream fos = new FileOutputStream(uploadPath);
			InputStream is = file.getInputStream();

			byte[] data = new byte[is.available()];
			is.read(data);
			fos.write(data);
			fos.close();

			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

			PreparedStatement pst = con.prepareStatement("insert into product(pimgname, pname, price) values(?,?,?)");
			pst.setString(1, imageFileName);
			pst.setString(2, pname);
			pst.setString(3, price);

			int rowCount = pst.executeUpdate();

			if (rowCount > 0) {

				/* dispatcher = request.getRequestDispatcher("admin/products.jsp"); */
				response.sendRedirect("admin/products.jsp"); 

			} else {

				/* dispatcher = request.getRequestDispatcher("admin/add-product.jsp"); */
				response.sendRedirect("admin/add-product.jsp"); 
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
