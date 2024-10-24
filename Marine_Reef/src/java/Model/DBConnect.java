/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author
 */
public class DBConnect {

    private static ArrayList<Product> arrProduct = new ArrayList<>();
    private static ArrayList<User> arrUser = new ArrayList<>();
    private static ArrayList<CartDetail> arrCart = new ArrayList<>();

    public static Connection getConnection() {
        Connection con = null;
        String dbUser = "sa";
        String dbPassword = "admin";
        String port = "1433";
        String IP = "127.0.0.1";
        String ServerName = "minipele";
        String DBName = "SalesWebsite";
        String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

        String dbURL = "jdbc:sqlserver://minipele;databaseName=SalesWebsite;encrypt=false;trustServerCertificate=false;loginTimeout=30";

        try {
            Class.forName(driverClass);
            //DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
            con = (Connection) DriverManager.getConnection(dbURL, dbUser, dbPassword);
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return con;
    }

    public static boolean signupUser(String name, String pass, String email, String phone, Connection con) {
        try {

            String selectMaxIdSql = "SELECT MAX(CAST(customerID AS INT)) AS maxID FROM Customer";
            String insertSql = "INSERT INTO Customer (CustomerID, CustomerName, Phone, Email, Address) VALUES (?, ?, ?, ?, ?)";

            // Lấy customerID cao nhất
            String newCustomerId = "1"; // Mặc định là 1 nếu bảng rỗng
            PreparedStatement selectStmt = con.prepareStatement(selectMaxIdSql);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                newCustomerId = String.valueOf(rs.getInt("maxID") + 1); // Tính toán customerID mới
            }
            // Chèn khách hàng mới
            PreparedStatement insertStmt = con.prepareStatement(insertSql);
            insertStmt.setString(1, newCustomerId);
            insertStmt.setString(2, " ");
            insertStmt.setString(3, phone);
            insertStmt.setString(4, email);
            insertStmt.setString(5, " ");
            insertStmt.executeUpdate();
            String sql = "INSERT INTO [User] (Username, Password, CustomerID) VALUES (?, ?, ?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, pass);
            pstmt.setString(3, newCustomerId);
            pstmt.executeUpdate();

            String selectMaxCartSql = "SELECT MAX(CAST(CartID AS INT)) AS maxID FROM Cart";
            String cartSql = "INSERT INTO Cart (CartID, CustomerID) VALUES (?, ?)";

            // Lấy customerID cao nhất
            String newCartId = "1"; // Mặc định là 1 nếu bảng rỗng
            PreparedStatement cartstmt = con.prepareStatement(selectMaxCartSql);
            ResultSet rs1 = cartstmt.executeQuery();
            if (rs1.next()) {
                newCartId = String.valueOf(rs1.getInt("maxID") + 1); // Tính toán customerID mới
            }
            // Chèn khách hàng mới
            PreparedStatement insertCartStmt = con.prepareStatement(cartSql);
            insertCartStmt.setString(1, newCartId);
            insertCartStmt.setString(2, newCustomerId);
            insertCartStmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String getCustomerID(String username, Connection con) {
        String customerID = null;
        try {
            String sql = "SELECT CustomerID FROM [User] WHERE Username = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                customerID = resultSet.getString("CustomerID");
            }

        } catch (Exception e) {
            e.printStackTrace(); // Xử lý lỗi nếu có
        }
        return customerID;
    }

    public static boolean addCartDetail(Product p, String username, int quantity, Connection con) {
        try {
          
            String cartID = getCartID(username, con);
            // Lấy customerID cao nhất
          
            System.out.println("Da den day");
            String cartSql = "MERGE INTO CartDetail AS target " +
                         "USING (VALUES (?, ?, ?)) AS source (CartID, ProductID, Quantity) " +
                         "ON (target.CartID = source.CartID AND target.ProductID = source.ProductID) " +
                         "WHEN MATCHED THEN " +
                         "UPDATE SET target.Quantity = target.Quantity + source.Quantity " +
                         "WHEN NOT MATCHED THEN " +
                         "INSERT (CartID, ProductID, Quantity) " +
                         "VALUES (source.CartID, source.ProductID, source.Quantity);";
            
            PreparedStatement stmt = con.prepareStatement(cartSql);
            stmt.setString(1, cartID);
            stmt.setString(2, p.getProductID());
            stmt.setInt(3, quantity);
            System.out.println(stmt);
            stmt.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Loi add cartdetail");
        }
        return false;
    }

    public static String getCartID(String username, Connection con) {
        String cartID = "";
        try {
            String cusID = getCustomerID(username, con);
                        System.out.println("CusID:"+cusID);

            String sql = "SELECT CartID FROM Cart WHERE CustomerID = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, cusID);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                cartID = resultSet.getString("CartID");
            }
        } catch (Exception e) {
            System.out.println("Loi get cartID");
            e.printStackTrace();
        }
        System.out.println("Con cac:"+cartID);
        return cartID;
    }

    public static ArrayList<CartDetail> getCart(String username, Connection con) {
        try {
            arrCart.clear();
            String cusID = getCustomerID(username, con);
            String cartID = "";
            String sql = "SELECT CartID FROM Cart WHERE CustomerID = ?";
            PreparedStatement preparedStatement = con.prepareStatement(sql);
            preparedStatement.setString(1, cusID);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                cartID = resultSet.getString("CartID");
            }
            String detailsql = "SELECT * FROM CartDetail WHERE CartID = ?";
            PreparedStatement stmt = con.prepareStatement(detailsql);
            stmt.setString(1, cartID);
            ResultSet rs = stmt.executeQuery();
            String productID;

            int quantity;
            while (rs.next()) {
                productID = rs.getString("ProductID");
                quantity = rs.getInt("Quantity");
                arrCart.add(new CartDetail(cartID, productID, quantity));
            }
        } catch (Exception e) {
            System.out.println("Loi roi");
            e.printStackTrace();
        }
        return arrCart;
    }

    public static ArrayList<User> getUser(Connection con) {
        try {
            String sql = "SELECT * FROM [User]";
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            String name, pass, id;
            arrUser.clear();
            while (resultSet.next()) {
                name = resultSet.getString("Username");
                pass = resultSet.getString("Password");
                id = resultSet.getString("CustomerID");
                arrUser.add(new User(name, pass, id));
            }
        } catch (Exception e) {
            System.out.println("Loi get User");
            e.printStackTrace();
        }
        return arrUser;
    }

    public static ArrayList<Product> getProduct(Connection con) {
        try {
            String sql = "SELECT * FROM Product";
            Statement statement = con.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            System.out.println(resultSet);
            arrProduct.clear();
            String productID, name, type, description, categoryID;
            BigDecimal price, costPrice;
            int quantity;
            while (resultSet.next()) {
                productID = resultSet.getString("ProductID");
                name = resultSet.getString("Name");
                description = resultSet.getString("Description");
                price = resultSet.getBigDecimal("Price");
                quantity = resultSet.getInt("QuantityInStock");
                categoryID = resultSet.getString("CategoryID");
                costPrice = resultSet.getBigDecimal("CostPrice");
                type = resultSet.getString("Type");
                arrProduct.add(new Product(productID, name, type, description, price, costPrice, quantity, categoryID));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error");
        }
        return arrProduct;
    }
    public static Product getProductbyID(String id, Connection con){
        try {
            String sql = "SELECT * FROM Product WHERE ProductID = ?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            String productID, name, type, description, categoryID;
            BigDecimal price, costPrice;
            int quantity;
            if (rs.next()) {
                productID = rs.getString("ProductID");
                name = rs.getString("Name");
                description = rs.getString("Description");
                price = rs.getBigDecimal("Price");
                quantity = rs.getInt("QuantityInStock");
                categoryID = rs.getString("CategoryID");
                costPrice = rs.getBigDecimal("CostPrice");
                type = rs.getString("Type");
                return new Product(productID, name, type, description, price, costPrice, quantity, categoryID);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error lay product");
        }
        return null;

    }


}
