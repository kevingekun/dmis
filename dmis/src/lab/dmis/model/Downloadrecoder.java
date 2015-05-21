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
public class Downloadrecoder implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Doc doc;
	private Timestamp downloadTime;
	private Integer id;
	private User user;

	@ManyToOne
	@JoinColumn(name = "docId")
	public Doc getDoc() {
		return this.doc;
	}

	@Column(nullable = false)
	public Timestamp getDownloadTime() {
		return this.downloadTime;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	@ManyToOne
	@JoinColumn(name = "userId")
	public User getUser() {
		return this.user;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

	public void setDownloadTime(Timestamp downloadTime) {
		this.downloadTime = downloadTime;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setUser(User user) {
		this.user = user;
	}

}