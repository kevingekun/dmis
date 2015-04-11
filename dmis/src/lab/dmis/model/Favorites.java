package lab.dmis.model;

import java.sql.Timestamp;

/**
 * Favorites entity. @author MyEclipse Persistence Tools
 */

public class Favorites implements java.io.Serializable {

	// Fields

	private Integer id;
	private Doc doc;
	private User user;
	private Timestamp time;

	// Constructors

	/** default constructor */
	public Favorites() {
	}

	/** full constructor */
	public Favorites(Doc doc, User user, Timestamp time) {
		this.doc = doc;
		this.user = user;
		this.time = time;
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

}