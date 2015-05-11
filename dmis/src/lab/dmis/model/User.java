package lab.dmis.model;

import java.util.HashSet;
import java.util.Set;

/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String password;
	private String phone;
	private String email;
	private String qq;
	private Boolean isForbidden;
	private Integer role;
	private Integer level;
	private String question;
	private String answer;
	private String verfi;
	private String newPassword;
	private Set searchhistories = new HashSet(0);
	private Set favoriteses = new HashSet(0);
	private Set downloadrecoders = new HashSet(0);
	private Set docs = new HashSet(0);
	private Set comments = new HashSet(0);

	// Constructors

	/** default constructor */
	public User() {
	}

	/** minimal constructor */
	public User(String name, String password, String phone, String email,
			String qq, Boolean isForbidden, Integer role, Integer level,
			String question, String answer, String newPassword, String verfi) {
		this.name = name;
		this.password = password;
		this.phone = phone;
		this.email = email;
		this.qq = qq;
		this.isForbidden = isForbidden;
		this.role = role;
		this.level = level;
		this.question = question;
		this.answer = answer;
		this.newPassword = newPassword;
		this.verfi = verfi;
	}

	/** full constructor */
	public User(String name, String password, String phone, String email,
			String qq, Boolean isForbidden, Integer role, Integer level,
			String question, String answer, String newPassword, String verfi,
			Set searchhistories, Set favoriteses, Set downloadrecoders,
			Set docs, Set comments) {
		this.name = name;
		this.password = password;
		this.phone = phone;
		this.email = email;
		this.qq = qq;
		this.isForbidden = isForbidden;
		this.role = role;
		this.level = level;
		this.question = question;
		this.answer = answer;
		this.newPassword = newPassword;
		this.verfi = verfi;
		this.searchhistories = searchhistories;
		this.favoriteses = favoriteses;
		this.downloadrecoders = downloadrecoders;
		this.docs = docs;
		this.comments = comments;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public Boolean getIsForbidden() {
		return this.isForbidden;
	}

	public void setIsForbidden(Boolean isForbidden) {
		this.isForbidden = isForbidden;
	}

	public Integer getRole() {
		return this.role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getQuestion() {
		return this.question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return this.answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getVerfi() {
		return verfi;
	}

	public void setVerfi(String verfi) {
		this.verfi = verfi;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public Set getSearchhistories() {
		return this.searchhistories;
	}

	public void setSearchhistories(Set searchhistories) {
		this.searchhistories = searchhistories;
	}

	public Set getFavoriteses() {
		return this.favoriteses;
	}

	public void setFavoriteses(Set favoriteses) {
		this.favoriteses = favoriteses;
	}

	public Set getDownloadrecoders() {
		return this.downloadrecoders;
	}

	public void setDownloadrecoders(Set downloadrecoders) {
		this.downloadrecoders = downloadrecoders;
	}

	public Set getDocs() {
		return this.docs;
	}

	public void setDocs(Set docs) {
		this.docs = docs;
	}

	public Set getComments() {
		return this.comments;
	}

	public void setComments(Set comments) {
		this.comments = comments;
	}

}