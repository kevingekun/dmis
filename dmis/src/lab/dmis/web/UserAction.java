package lab.dmis.web;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import lab.common.web.BaseAction;
import lab.dmis.model.User;
import lab.dmis.service.DocService;
import lab.dmis.service.NoticeService;
import lab.dmis.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;

public class UserAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private UserService userService;
	@Autowired
	private DocService docService;
	@Autowired
	private NoticeService noticeService;

	private User user;
	private int pageNo = 1;
	private int pageContSize = 3;

	/**
	 * 直接请求页面
	 * 
	 * @return
	 */
	public String pageRequest() {

		return SUCCESS;
	}

	/**
	 * 管理员请求页面
	 */
	public String getAdminIndex() {
		return "index";
	}

	/**
	 * 用户登出
	 * 
	 * @return
	 */
	public String LoginOut() {
		removeObjFromSession("LOGIN_USER");
		return "loginOut";
	}

	/**
	 * 跳转用户中心
	 * 
	 * @return
	 */
	public String getAllInfo() {

		return "personalCenter";
	}

	public String respassword() {
		return "loginOut";
	}

	/*
	 * public String loginIndex(){
	 * 
	 * setAttribute("recentDoc",docService.getPage(1, 5));
	 * setAttribute("recentNotice",noticeService.getPage(1, 5));
	 * return"LoginIndex"; }
	 */
	/**
	 * 加载全部用户
	 * 
	 * @return
	 */
	public String list() {
		int state = Integer.parseInt(getParameter("state"));
		if (getParameter("pageNo") == null) {
			setAttribute("page",
					userService.getPage(state, pageNo, pageContSize));
			setAttribute("state", state);
			return "list";
		} else {
			setAttribute("page", userService.getPage(state,
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", state);
			return "list";
		}

	}

	public String listByState() {
		setAttribute("page", userService.getPage(pageNo, pageContSize));
		return "list";
	}

	/**
	 * 添加用户
	 * 
	 * @return
	 */
	public String add() {
		String username = user.getName();
		String regex = "([0-9]|[A-Z]|[a-z]|[\\w])+";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(username);
		if (m.matches()) {
			if (userService.checkUserName(username).size() != 0) {
				return "error";
			} else {
				userService.addUser(user);
				int totalpage = userService.getPage(pageNo, pageContSize)
						.getTotalPage();
				getRequest().setAttribute("pageNo", totalpage);
				return "listUser";
			}
		} else {
			return "error";
		}

	}

	/**
	 * 
	 * @return
	 */
	public String listUser() {
		pageNo = Integer.parseInt(getParameter("pageNo"));
		setAttribute("page", userService.getPage(1, 1, pageContSize));
		setAttribute("state", 1);
		return "list";
	}

	/**
	 * 删除用户
	 * 
	 * @return
	 */
	public String delete2() {
		userService.deleteById(Integer.parseInt(getParameter("id")));
		int totalpage = userService.getPage(pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "listUser";
	}

	/**
	 * 批量删除用户
	 * 
	 * @return
	 */
	public String delete() {
		String[] ids = new String[pageContSize];
		String id = getParameter("id");
		if (id != null) {
			ids[0] = id;
		} else {
			ids = getRequest().getParameterValues("checkAll");
		}
		userService.deleteByIds(ids);
		int totalpage = userService.getPage(pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		System.out.println(pageNo);
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "listUser";
	}

	/**
	 * 用户禁用
	 * 
	 * @return
	 */
	public String forbidden() {
		List<User> u = userService.findById(Integer
				.parseInt(getParameter("id")));
		user = u.get(0);
		if (user.getIsForbidden() == true) {
			user.setIsForbidden(false);
		} else {
			user.setIsForbidden(true);
		}
		userService.changeState(user);
		getRequest().setAttribute("pageNo", getParameter("pageNo"));
		return "listUser";
	}

	/**
	 * 修改用户资料
	 * 
	 * @return
	 * @throws IOException
	 */
	public void updateUser() throws IOException {
		User uu = (User) getSession().getAttribute("LOGIN_USER");
		// String question=uu.getQuestion();
		// String answer=uu.getAnswer();
		// if(question.equals(getParameter("question")))
		// {
		// if(answer.equals(getParameter("answer")))
		// {
		uu.setEmail(getParameter("email"));
		uu.setPhone(getParameter("phone"));
		uu.setQq(getParameter("qq"));
		uu.setAnswer(getParameter("answer"));
		uu.setQuestion(getParameter("question"));
		userService.editUser(uu);
		// }
		// List<User> u=userService.findById(uu.getId());
		// getSession().setAttribute("LOGIN_USER",u.get(0));
		out().print("true");
		// }
		// else
		// {
		// out().print("false");
		// }

	}

	public void resetpassword() throws IOException {
		User uu = (User) getSession().getAttribute("LOGIN_USER");
		String password = uu.getPassword();
		if (password.equals(getParameter("oldpassword"))) {
			uu.setPassword(getParameter("newpassword"));
			// if(uu.getPassword("newpassword").equals)
			userService.resetPassword(uu);
			// List<User> u=userService.findById(uu.getId());
			// getSession().setAttribute("LOGIN_USER",u.get(0));
			out().print("true");
		}
		// out().print("false");
		// return"resetpassword";
	}

	/**
	 * 检查用户名是否存在
	 * 
	 * @throws IOException
	 */
	public void checkUserName() throws IOException {
		String username = getParameter("username");
		if (userService.checkUserName(username).size() != 0) {
			out().print("false");
		} else {
			out().print("true");
		}
	}

	/**
	 * 修改用户级别
	 * 
	 * @throws IOException
	 */
	public void changRole() throws IOException {
		int role = Integer.parseInt(getParameter("role"));
		List<User> u = userService.findById(Integer
				.parseInt(getParameter("id")));
		user = u.get(0);
		user.setRole(role);
		userService.changeState(user);
		out().print("true");
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

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageContSize() {
		return pageContSize;
	}

	public void setPageContSize(int pageContSize) {
		this.pageContSize = pageContSize;
	}

}
