package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * DBConnection – kết nối JDBC thuần dùng cho phần User (không dùng JPA).
 *
 * [LỖI 8 – Lưu ý kiến trúc]
 * Project này đang dùng HAI cơ chế truy cập DB song song:
 *   - JPA/Hibernate  → Category & Video  → DB: webst4  (port 1434, persistence.xml)
 *   - JDBC thuần     → User              → DB: LTWeb   (port 1433, class này)
 *
 * Điều này gây ra sự không đồng nhất. Nếu muốn thống nhất, hãy chọn một trong hai:
 *   1. Dùng JPA cho tất cả: tạo entity User, thêm vào persistence.xml
 *   2. Dùng JDBC cho tất cả: thay CategoryDaoImpl bằng JDBC
 *
 * Hiện tại đảm bảo cả hai DB đều đang chạy trước khi khởi động ứng dụng.
 */
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
