package lab.dmis.model;

import java.sql.Timestamp;

/**
 * Downloadrecoder entity. @author MyEclipse Persistence Tools
 */

public class Downloadrecoder implements java.io.Serializable {

	// Fields

	private Integer id;
	private Doc doc;
	private User user;
	private Timestamp downloadTime;

	// Constructors

	/** default constructor */
	public Downloadrecoder() {
	}

	/** full constructor */
	public Downloadrecoder(Doc doc, User user, Timestamp downloadTime) {
		this.doc = doc;
		this.user = user;
		this.downloadTime = downloadTime;
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

	public Timestamp getDownloadTime() {
		return this.downloadTime;
	}

	public void setDownloadTime(Timestamp downloadTime) {
		this.downloadTime = downloadTime;
	}

}