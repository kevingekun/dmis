package lab.dmis.model;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;

/**
 * Comment entity. @author MyEclipse Persistence Tools
 */

public class Comment implements java.io.Serializable {

	// Fields

	private Integer id;
	private Doc doc;
	private User user;
	private Timestamp time;
	private String content;
	private Integer numOfApplications;
	private String usersOfApplications;
	private Integer haveHandled;
	

	// Constructors

	/** default constructor */
	public Comment() {
	}

	/** full constructor */
	public Comment(Doc doc, User user, Timestamp time, String content) {
		this.doc = doc;
		this.user = user;
		this.time = time;
		this.content = content;
	}
	
	/**
	 * timestamp to string
	 * @return
	 */
	
	public String getDate(){
		DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");  
       
         return  sdf.format(this.time);  
           
	}
	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Doc getDoc() {
		return this.doc;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getNumOfApplications() {
		return numOfApplications;
	}

	public void setNumOfApplications(Integer numOfApplications) {
		this.numOfApplications = numOfApplications;
	}

	public String getUsersOfApplications() {
		return usersOfApplications;
	}

	public void setUsersOfApplications(String usersOfApplications) {
		this.usersOfApplications = usersOfApplications;
	}

	public Integer getHaveHandled() {
		return haveHandled;
	}

	public void setHaveHandled(Integer haveHandled) {
		this.haveHandled = haveHandled;
	}
	

}