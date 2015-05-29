package lab.dmis.service;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.User;

public interface UserService extends BaseManager<User, Integer> {

	public List<User> loginCheck(User user);

	public List<User> forgotCheck(User user);

	public List<User> NameAndVerfiCheck(User user);

	public void PasswordUpdate(User user);

	public Page getPage(int pageNo, int pageContSize);

	public Page getPage(int state, int pageNo, int pageContSize);

	public Page getPage(int pageNo, int pageContSize, boolean isForbidden);

	public void deleteByIds(List<String> ids);

	public void addUser(User user);

	public void changeState(User user);

	public List<User> findById(int id);

	public void resetPassword(User user);

	public List<User> checkUserName(String username);

}
