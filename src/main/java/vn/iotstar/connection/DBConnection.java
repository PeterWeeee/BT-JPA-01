package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private final String serverName = "localhost";
    private final String dbName = "LTWeb";
    private final String portNumber = "1433";
    private final String instance = ""; // Bỏ trống nếu là instance mặc định, hoặc điền "SQLEXPRESS" nếu dùng bản Express
    private final String userID = "sa";
    private final String password = "123456";

    public Connection getConnection() throws Exception {
        String url;
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName
                    + ";encrypt=true;trustServerCertificate=true;";
        } else {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName
                    + ";encrypt=true;trustServerCertificate=true;";
        }
        
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    public static void main(String[] args) {
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("Kết nối SQL Server thành công!");
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Lỗi kết nối SQL Server: " + e.getMessage());
        }
    }
}
