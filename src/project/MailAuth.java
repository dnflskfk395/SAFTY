package project;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuth extends Authenticator{

    PasswordAuthentication pa;

    public MailAuth() {
        String mail_id = "본인의 GMAIL";
        String mail_pw = "본인의 GMAIL 비밀번호";

        pa = new PasswordAuthentication(mail_id, mail_pw);
    }

    public PasswordAuthentication getPasswordAuthentication() {
        return pa;
    }
}


