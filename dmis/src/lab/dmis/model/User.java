package lab.dmis.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Transient;

import lab.dmis.vo.UserVo;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class User implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String email;
	private Integer id;
	private Boolean isForbidden;
	private Integer level;
	private String name;
	private String password;
	private String phone;
	private String qq;
	private Integer role;
	private String verfi;

	

	public User() {
	}
	public User(UserVo userVo){
		this.name = userVo.getName();
		this.password = userVo.getPassword();
	}

	@Column(unique = true)
	public String getEmail() {
		return this.email;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	public Boolean getIsForbidden() {
		return this.isForbidden;
	}

	public Integer getLevel() {
		return level;
	}

	@Column(nullable = false, unique = true)
	public String getName() {
		return name;
	}


	@Column(nullable = false)
	public String getPassword() {
		return this.password;
	}

	@Column(unique = true)
	public String getPhone() {
		return this.phone;
	}

	@Column(unique = true)
	public String getQq() {
		return this.qq;
	}

	public Integer getRole() {
		return this.role;
	}

	@Transient
	public String getVerfi() {
		return verfi;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setIsForbidden(Boolean isForbidden) {
		this.isForbidden = isForbidden;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	public void setVerfi(String verfi) {
		this.verfi = verfi;
	}

}