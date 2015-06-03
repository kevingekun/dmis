package lab.dmis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.UserDao;
import lab.dmis.model.User;
import lab.dmis.service.UserService;

import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends BaseManagerImpl<User, Integer> implements
		UserService {

	private UserDao userDaoImpl;

	/**
	 * 用户登录检查
	 */
	@SuppressWarnings("unchecked")
	public List<User> loginCheck(User user){
		String hql = "from User user where user.name ='" + user.getName()
				+ "' and user.password = '" + user.getPassword() + "'";
		return userDaoImpl.find(hql);
	}

	/**
	 * 根据邮箱找回密码
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> forgotCheck(User user) {
		String hql = "from User user where user.name ='" + user.getName()
				+ "' and user.email = '" + user.getEmail() + "'";
		return userDaoImpl.find(hql);
	}

	/**
	 * 验证用户名是否存在已经验证码是否正确
	 */
	@SuppressWarnings("unchecked")
	public List<User> NameAndVerfiCheck(User user) {
		String hql = "from User user where user.name = '" + user.getName()
				+ "'";
		return userDaoImpl.find(hql);
	}

	/**
	 * 用户重置密码
	 */
	public void PasswordUpdate(User user) {
		userDaoImpl.update(user);
	}

	public void resetPassword(User user) {
		userDaoImpl.update(user);
	}

	/**
	 * 加载全部用户
	 */
	public Page getPage(int pageNo, int pageContSize) {
		String sql = "from User";
		return userDaoImpl.getPage(sql, pageNo, pageContSize);
	}

	public Page getPage(int state, int pageNo, int pageContSize) {
		// String sql = "from User";
		String hql1 = "from User u  order by u.id DESC";
		String hql2 = "from User u where u.isForbidden=1 order by u.id DESC";
		if (state == 1) {
			return userDaoImpl.getPage(hql1, pageNo, pageContSize);
		} else {
			return userDaoImpl.getPage(hql2, pageNo, pageContSize);
		}
	}

	public Page getPage(int pageNo, int pageContSize, boolean isForbidden) {
		int isF = 0;
		if(isForbidden == true){
			isF = 1;
		}
		String hql = "from User u where u.isForbidden='"+isF+"'  order by u.id DESC";
		return userDaoImpl.getPage(hql, pageNo, pageContSize);
	}

	@Override
	public void deleteByIds(List<String> ids) {
		for (int i = 0; i < ids.size(); i++) {
			int id = Integer.parseInt(ids.get(i));
			userDaoImpl.deleteByKey(id);
		}
	}

	/**
	 * 添加用户
	 */
	@Override
	public void addUser(User user) {
		userDaoImpl.save(user);
	}

	/**
	 * 更改用户状态
	 */
	@Override
	public void changeState(User user) {
		userDaoImpl.update(user);
	}

	/**
	 * 根据用户ID查找
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> findById(int id) {
		String sql = "from User where id='" + id + "'";
		return userDaoImpl.find(sql);
	}

	/**
	 * 检查用户名是否存在
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> checkUserName(String username) {
		String sql = "from User user where user.name='" + username + "'";
		return userDaoImpl.find(sql);
	}

	public UserDao getUserDaoImpl() {
		return userDaoImpl;
	}

	@Resource
	public void setUserDaoImpl(UserDao userDaoImpl) {
		this.userDaoImpl = userDaoImpl;
	}

}
