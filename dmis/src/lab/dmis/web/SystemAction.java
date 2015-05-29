package lab.dmis.web;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import lab.common.web.BaseAction;
import lab.dmis.model.User;
import lab.dmis.service.UserService;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("systemAction")
@Scope("prototype")
public class SystemAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private InputStream inputStream;

	private UserService userServiceImpl;

	private User user;

	/**
	 * 用户登录页面
	 * 
	 * @return
	 */
	public String Login() {
		return "success";
	}

	/**
	 * 用户登录验证
	 * 
	 * @return
	 */
	public String LoginCheck() {
		List<User> list = userServiceImpl.loginCheck(user);
		if (list.size() != 0)
			putObjToSession("LOGIN_USER", list.get(0));
		String name = user.getName();
		System.err.println(name);
		if (name.equals("admin")) {
			inputStream = outStream(list.size() != 0 ? "admin" : "failed");
		} else {
			inputStream = outStream(list.size() != 0 ? "success" : "failed");
		}
		return "login";
	}

	/**
	 * 通过邮件找回密码
	 * 
	 * @throws MessagingException
	 * @throws IOException
	 */

	public void UpdatePasswordBySendMail() throws Exception {
		List<User> list = userServiceImpl.forgotCheck(user);
		if (list.size() != 0 && list.get(0).getEmail() != null) {
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.163.com");
			props.put("mail.smtp.auth", "true");
			// 基本的邮件会话
			Session session = Session.getInstance(props);
			// 构造信息体
			MimeMessage message = new MimeMessage(session);
			// 发件地址
			Address address = new InternetAddress("kevingekun@163.com");
			message.setFrom(address);
			// 收件地址
			Address toAddress = new InternetAddress(list.get(0).getEmail());
			message.setRecipient(MimeMessage.RecipientType.TO, toAddress);

			String subject = "DIMS 密码找回";
			// 主题
			message.setSubject(subject);
			String text = "您的新密码为：";
			int password = (int) ((Math.random() * 9 + 1) * 100000);
			String end = "请尽快登录系统修改密码！";
			// 正文
			message.setText(text + password + end);
			list.get(0).setPassword(String.valueOf(password));
			userServiceImpl.update(list.get(0));

			message.saveChanges();
			session.setDebug(true);// 控制台输出
			Transport transport = session.getTransport("smtp");
			transport.connect("smtp.163.com", "kevingekun@163.com",
					"klbqqlly1234");
			// 发送
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();

			out().print("success");
		} else {
			out().print("failed");
		}
	}

	public String menu() {
		return "menu";
	}

	public String top() {
		return "top";
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public UserService getUserServiceImpl() {
		return userServiceImpl;
	}

	@Resource
	public void setUserServiceImpl(UserService userServiceImpl) {
		this.userServiceImpl = userServiceImpl;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
