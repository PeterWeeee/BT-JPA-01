package vn.iotstar.utils;

import java.io.InputStream;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * EmailUtil – Tiện ích gửi email OTP qua SMTP (Gmail).
 * Cấu hình trong src/main/resources/email.properties
 */
public class EmailUtil {

    private static final Properties EMAIL_PROPS = new Properties();
    private static String FROM_EMAIL;
    private static String FROM_PASSWORD;
    private static String FROM_NAME;

    static {
        try (InputStream is = EmailUtil.class.getClassLoader().getResourceAsStream("email.properties")) {
            if (is != null) {
                EMAIL_PROPS.load(is);
                FROM_EMAIL = EMAIL_PROPS.getProperty("mail.from");
                FROM_PASSWORD = EMAIL_PROPS.getProperty("mail.password");
                FROM_NAME = EMAIL_PROPS.getProperty("mail.from.name", "IoTStar Shop");
            }
        } catch (Exception e) {
            System.err.println("[EmailUtil] Không thể tải email.properties: " + e.getMessage());
        }
    }

    /**
     * Gửi email OTP đến địa chỉ email đích.
     *
     * @param toEmail  Địa chỉ email người nhận
     * @param subject  Tiêu đề email
     * @param body     Nội dung email (HTML hoặc plain text)
     * @return true nếu gửi thành công, false nếu thất bại
     */
    public static boolean sendEmail(String toEmail, String subject, String body) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", EMAIL_PROPS.getProperty("mail.smtp.auth", "true"));
            props.put("mail.smtp.starttls.enable", EMAIL_PROPS.getProperty("mail.smtp.starttls.enable", "true"));
            props.put("mail.smtp.host", EMAIL_PROPS.getProperty("mail.smtp.host", "smtp.gmail.com"));
            props.put("mail.smtp.port", EMAIL_PROPS.getProperty("mail.smtp.port", "587"));

            final String user = FROM_EMAIL;
            final String password = FROM_PASSWORD;

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(user, password);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME, "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setContent(body, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("[EmailUtil] Đã gửi email đến: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("[EmailUtil] Lỗi gửi email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Tạo mã OTP ngẫu nhiên 6 chữ số.
     */
    public static String generateOtp() {
        int otp = (int) (Math.random() * 900000) + 100000;
        return String.valueOf(otp);
    }

    /**
     * Gửi OTP kích hoạt tài khoản.
     */
    public static boolean sendActivationOtp(String toEmail, String otp) {
        String subject = "[IoTStar Shop] Mã kích hoạt tài khoản";
        String body = "<div style='font-family:Arial,sans-serif;max-width:500px;margin:auto;padding:24px;border:1px solid #e2e8f0;border-radius:8px'>"
                + "<h2 style='color:#1e293b'>Kích Hoạt Tài Khoản</h2>"
                + "<p>Xin chào! Vui lòng nhập mã OTP dưới đây để kích hoạt tài khoản của bạn:</p>"
                + "<div style='font-size:32px;font-weight:bold;letter-spacing:8px;color:#3b82f6;text-align:center;padding:16px;background:#eff6ff;border-radius:6px;margin:16px 0'>"
                + otp
                + "</div>"
                + "<p style='color:#64748b;font-size:14px'>Mã OTP có hiệu lực trong <strong>10 phút</strong>. Không chia sẻ mã này với ai.</p>"
                + "<hr style='border:none;border-top:1px solid #e2e8f0;margin:16px 0'>"
                + "<p style='color:#94a3b8;font-size:12px'>IoTStar Shop – Email tự động, vui lòng không trả lời.</p>"
                + "</div>";
        return sendEmail(toEmail, subject, body);
    }

    /**
     * Gửi OTP đặt lại mật khẩu.
     */
    public static boolean sendResetPasswordOtp(String toEmail, String otp) {
        String subject = "[IoTStar Shop] Mã đặt lại mật khẩu";
        String body = "<div style='font-family:Arial,sans-serif;max-width:500px;margin:auto;padding:24px;border:1px solid #e2e8f0;border-radius:8px'>"
                + "<h2 style='color:#1e293b'>Đặt Lại Mật Khẩu</h2>"
                + "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu của bạn. Nhập mã OTP dưới đây:</p>"
                + "<div style='font-size:32px;font-weight:bold;letter-spacing:8px;color:#ef4444;text-align:center;padding:16px;background:#fef2f2;border-radius:6px;margin:16px 0'>"
                + otp
                + "</div>"
                + "<p style='color:#64748b;font-size:14px'>Mã OTP có hiệu lực trong <strong>10 phút</strong>. Nếu bạn không yêu cầu điều này, hãy bỏ qua email này.</p>"
                + "<hr style='border:none;border-top:1px solid #e2e8f0;margin:16px 0'>"
                + "<p style='color:#94a3b8;font-size:12px'>IoTStar Shop – Email tự động, vui lòng không trả lời.</p>"
                + "</div>";
        return sendEmail(toEmail, subject, body);
    }
}
