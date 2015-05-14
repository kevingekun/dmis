package lab.dmis.service.impl;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.UserDao;
import lab.dmis.model.User;
import lab.dmis.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends BaseManagerImpl<User, Integer> implements
		UserService {

	@Autowired
	private UserDao userDao;

	/**
	 * 用户登录检查
	 */
	@SuppressWarnings("unchecked")
	public List<User> loginCheck(User user) {
		String hql = "from User user where user.name ='" + user.getName()
				+ "' and user.password = '" + user.getPassword() + "'";
		return userDao.find(hql);
	}

	/**
	 * 根据邮箱找回密码
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> forgotCheck(User user) {
		String hql = "from User user where user.name ='" + user.getName()
				+ "' and user.email = '" + user.getEmail() + "'";
		return userDao.find(hql);
	}

	/**
	 * 验证用户名是否存在已经验证码是否正确
	 */
	@SuppressWarnings("unchecked")
	public List<User> NameAndVerfiCheck(User user) {
		String hql = "from User user where user.name = '" + user.getName()
				+ "'";
		return userDao.find(hql);
	}

	/**
	 * 更新用户资料，调用DAO层的update()存储到数据库
	 */
	public void editUser(User user) {

		userDao.update(user);

	}

	/**
	 * 用户重置密码
	 */
	public void PasswordUpdate(User user) {
		userDao.update(user);
	}

	public void resetPassword(User user) {
		userDao.update(user);
	}

	/**
	 * 加载全部用户
	 */
	public Page getPage(int pageNo, int pageContSize) {
		String sql = "from User";
		return userDao.getPage(sql, pageNo, pageContSize);
	}

	public Page getPage(int state, int pageNo, int pageContSize) {
		// String sql = "from User";
		String hql1 = "from User u  order by u.id DESC";
		String hql2 = "from User u where u.isForbidden=1 order by u.id DESC";
		if (state == 1) {
			return userDao.getPage(hql1, pageNo, pageContSize);
		} else {
			return userDao.getPage(hql2, pageNo, pageContSize);
		}
	}

	public Page getPage(int pageNo, int pageContSize, boolean isForbidden) {
		String hql = "from User u where u.isForbidden=1  order by u.id DESC";
		return userDao.getPage(hql, pageNo, pageContSize);
	}

	/**
	 * 删除用户
	 */
	@Override
	public void deleteById(int id) {
		userDao.deleteByKey(id);
	}

	@Override
	public void deleteByIds(String[] ids) {
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			userDao.deleteByKey(id);
		}

	}

	/**
	 * 添加用户
	 */
	@Override
	public void addUser(User user) {
		userDao.save(user);
	}

	/**
	 * 更改用户状态
	 */
	@Override
	public void changeState(User user) {
		userDao.update(user);
	}

	/**
	 * 根据用户ID查找
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> findById(int id) {
		String sql = "from User where id='" + id + "'";
		return userDao.find(sql);
	}

	/**
	 * 检查用户名是否存在
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> checkUserName(String username) {
		String sql = "from User user where user.name='" + username + "'";
		return userDao.find(sql);
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

}
