package lab.dmis.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Comment implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String content;
	private Doc doc;
	private Integer haveHandled;
	private Integer id;
	private Integer numOfApplications;
	private Timestamp time;
	private User user;
	private String usersOfApplications;

	/*
	 * public String getDate() { DateFormat sdf = new
	 * SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	 * 
	 * return sdf.format(this.time);
	 * 
	 * }
	 */

	@Column(nullable = false)
	public String getContent() {
		return this.content;
	}

	@ManyToOne
	@JoinColumn(name = "docId")
	public Doc getDoc() {
		return this.doc;
	}

	public Integer getHaveHandled() {
		return haveHandled;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	public Integer getNumOfApplications() {
		return numOfApplications;
	}

	@Column(nullable = false)
	public Timestamp getTime() {
		return this.time;
	}

	@ManyToOne
	@JoinColumn(name = "userId")
	public User getUser() {
		return this.user;
	}

	public String getUsersOfApplications() {
		return usersOfApplications;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

	public void setHaveHandled(Integer haveHandled) {
		this.haveHandled = haveHandled;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setNumOfApplications(Integer numOfApplications) {
		this.numOfApplications = numOfApplications;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setUsersOfApplications(String usersOfApplications) {
		this.usersOfApplications = usersOfApplications;
	}

}