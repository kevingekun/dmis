package lab.dmis.web;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

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
