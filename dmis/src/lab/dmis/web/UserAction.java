package lab.dmis.web;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import lab.common.web.BaseAction;
import lab.dmis.model.User;
import lab.dmis.service.UserService;

public class UserAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private UserService userServiceImpl;

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

	/**
	 * 加载全部用户
	 * 
	 * @return
	 */
	public String list() {
		int state = Integer.parseInt(getParameter("state"));
		if (getParameter("pageNo") == null) {
			setAttribute("page",
					userServiceImpl.getPage(state, pageNo, pageContSize));
			setAttribute("state", state);
			return "list";
		} else {
			setAttribute("page", userServiceImpl.getPage(state,
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", state);
			return "list";
		}

	}

	public String listByState() {
		setAttribute("page", userServiceImpl.getPage(pageNo, pageContSize));
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
			if (userServiceImpl.checkUserName(username).size() != 0) {
				return "error";
			} else {
				userServiceImpl.addUser(user);
				int totalpage = userServiceImpl.getPage(pageNo, pageContSize)
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
		setAttribute("page", userServiceImpl.getPage(1, 1, pageContSize));
		setAttribute("state", 1);
		return "list";
	}

	/**
	 * 删除用户
	 * 
	 * @return
	 */
	public String delete2() {
		userServiceImpl.deleteById(Integer.parseInt(getParameter("id")));
		int totalpage = userServiceImpl.getPage(pageNo, pageContSize)
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
		int state = Integer.parseInt(getParameter("state"));
		String[] ids = new String[pageContSize];
		String id = getParameter("id");
		boolean isF = false;
		if (state == 2) {
			isF = true;
		}
		if (id != null) {
			ids[0] = id;
		} else {
			ids = getRequest().getParameterValues("checkAll");
		}
		userServiceImpl.deleteByIds(ids);

		int totalpage = userServiceImpl.getPage(pageNo, pageContSize, isF)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		System.out.println(pageNo);
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				userServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	/**
	 * 用户禁用
	 * 
	 * @return
	 */
	public String forbidden() {
		int state = Integer.parseInt(getParameter("state"));
		int id = Integer.parseInt(getParameter("id"));
		boolean isF = false;
		int totalpage = 0;
		List<User> u = userServiceImpl.findById(id);
		System.err.println(id);
		user = u.get(0);
		if (user.getIsForbidden() == true) {
			user.setIsForbidden(false);
			isF = true;
		} else {
			user.setIsForbidden(true);
		}
		userServiceImpl.changeState(user);
		if (state == 1) {
			totalpage = userServiceImpl.getPage(pageNo, pageContSize)
					.getTotalPage();
		} else {
			totalpage = userServiceImpl.getPage(pageNo, pageContSize, isF)
					.getTotalPage();
		}
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				userServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	/**
	 * 检查用户名是否存在
	 * 
	 * @throws IOException
	 */
	public void checkUserName() throws IOException {
		String username = getParameter("username");
		if (userServiceImpl.checkUserName(username).size() != 0) {
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
		List<User> u = userServiceImpl.findById(Integer
				.parseInt(getParameter("id")));
		user = u.get(0);
		user.setRole(role);
		userServiceImpl.changeState(user);
		out().print("true");
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
