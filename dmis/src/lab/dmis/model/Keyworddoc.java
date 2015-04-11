package lab.dmis.model;

/**
 * Keyworddoc entity. @author MyEclipse Persistence Tools
 */

public class Keyworddoc implements java.io.Serializable {

	// Fields

	private Integer id;
	private Keyword keyword;
	private Doc doc;

	// Constructors

	/** default constructor */
	public Keyworddoc() {
	}

	/** full constructor */
	public Keyworddoc(Keyword keyword, Doc doc) {
		this.keyword = keyword;
		this.doc = doc;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Keyword getKeyword() {
		return this.keyword;
	}

	public void setKeyword(Keyword keyword) {
		this.keyword = keyword;
	}

	public Doc getDoc() {
		return this.doc;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

}