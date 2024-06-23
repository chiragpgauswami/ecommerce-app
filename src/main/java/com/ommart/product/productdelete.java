package com.ommart.product;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.dbcon;

/**
 * Servlet implementation class productdelete
 */
@WebServlet("/productdelete")
public class productdelete extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        dbcon db = new dbcon();
        Connection con = null;
        String id = request.getParameter("id");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(db.getDbUrl(), db.getUname(), db.getDbPsw());

            PreparedStatement pst1 = con.prepareStatement("DELETE FROM tblcart WHERE product_id= ?");
            pst1.setString(1, id);

            int rowCount1 = pst1.executeUpdate();

            if (rowCount1 > 0) {
                PreparedStatement pst = con.prepareStatement("DELETE FROM product WHERE id= ?");
                pst.setString(1, id);

                int rowCount = pst.executeUpdate();

                if (rowCount > 0) {
                    response.sendRedirect("admin/products.jsp");
                }
            } else {
                PreparedStatement pst = con.prepareStatement("DELETE FROM product WHERE id= ?");
                pst.setString(1, id);

                int rowCount = pst.executeUpdate();

                if (rowCount > 0) {
                    response.sendRedirect("admin/products.jsp");
                }
            }

        } catch (Exception e) {
            System.out.print(e);
            e.printStackTrace();
        }

    }

}
