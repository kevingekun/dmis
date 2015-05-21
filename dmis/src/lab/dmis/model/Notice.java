package lab.dmis.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Notice implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String content;
	private Integer id;
	private Timestamp time;
	private String title;

	@Column(nullable = false)
	public String getContent() {
		return this.content;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	@Column(nullable = false)
	public Timestamp getTime() {
		return this.time;
	}

	@Column(nullable = false)
	public String getTitle() {
		return this.title;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}