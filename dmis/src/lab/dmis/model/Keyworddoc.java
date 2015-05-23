package lab.dmis.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Keyworddoc implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Doc doc;
	private Integer id;
	private Keyword keyword;

	@ManyToOne
	@JoinColumn(name = "docId")
	public Doc getDoc() {
		return this.doc;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	@ManyToOne
	@JoinColumn(name = "keywordId")
	public Keyword getKeyword() {
		return this.keyword;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setKeyword(Keyword keyword) {
		this.keyword = keyword;
	}

}