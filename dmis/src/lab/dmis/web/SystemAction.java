package lab.dmis.web;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import lab.common.web.BaseAction;
import lab.dmis.model.User;
import lab.dmis.service.UserService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;
import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author Joki
 * 
 */

public class SystemAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private InputStream inputStream;

	@Autowired
	private UserService userService;

	private User user;

	String message = "";
	@SuppressWarnings("rawtypes")
	List<?> list = new ArrayList();

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
		list = userService.loginCheck(user);
		if (list.size() != 0)
			putObjToSession("LOGIN_USER", list.get(0));
		String nameString = user.getName();
		System.err.println(nameString);
		if (nameString.equals("admin")) {
			inputStream = outStream(list.size() != 0 ? "admin" : "failed");
		} else {
			inputStream = outStream(list.size() != 0 ? "success" : "failed");
		}
		return "login";
	}

	/**
	 * 验证用户名及验证码
	 * 
	 * @throws IOException
	 */
	public void NameAndVerfiCheck() throws IOException {
		list = userService.NameAndVerfiCheck(user);
		if (list.size() != 0) {
			if (user.getVerfi().equals(getAttribute("VCID")))
				message = JSONArray.fromObject(list,
						JsonSerialization.jsonSer(Str.str)).toString();
			else
				message = "0";
		} else
			message = "1";
		out().print(message);
	}

	/**
	 * 用户重置密码
	 * 
	 * @throws IOException
	 */
	public void PasswordUpdate() throws IOException {
		List<User> list = userService.NameAndVerfiCheck(user);
		if (user.getAnswer().equals(list.get(0).getAnswer())) {
			list.get(0).setPassword(user.getNewPassword());
			userService.PasswordUpdate(list.get(0));
			message = "success";
		} else
			message = "field";
		out().print(message);
	}

	/**
	 * 通过邮件找回密码
	 * 
	 * @throws MessagingException
	 * @throws IOException
	 */

	public void UpdatePasswordBySendMail() throws Exception {
		List<User> list = userService.forgotCheck(user);
		if (list.size() != 0) {
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
			Address toAddress = new InternetAddress("1021813835@qq.com");
			message.setRecipient(MimeMessage.RecipientType.TO, toAddress);

			String subject = "DIMS 密码找回";
			// 主题
			message.setSubject(subject);
			String text = "您的新密码为：";
			int password = (int) ((Math.random() * 9 + 1) * 100000);
			// 正文
			message.setText(text + password);
			list.get(0).setPassword(String.valueOf(password));
			userService.update(list.get(0));

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

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
