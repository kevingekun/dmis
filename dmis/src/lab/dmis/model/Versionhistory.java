package lab.dmis.model;

import java.sql.Timestamp;

/**
 * Versionhistory entity. @author MyEclipse Persistence Tools
 */

public class Versionhistory implements java.io.Serializable {

	// Fields

	private Integer id;
	private Doc doc;
	private String author;
	private Timestamp uploadTime;
	private String docPath;
	private Boolean available;
	private Float version;
	private Integer originalDocId;
	// Constructors

	/** default constructor */
	public Versionhistory() {
	}

	/** full constructor */
	public Versionhistory(Doc doc, String author, Timestamp uploadTime,
			String docPath, Boolean available, Float version) {
		this.doc = doc;
		this.author = author;
		this.uploadTime = uploadTime;
		this.docPath = docPath;
		this.available = available;
		this.version = version;
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

	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Timestamp getUploadTime() {
		return this.uploadTime;
	}

	public void setUploadTime(Timestamp uploadTime) {
		this.uploadTime = uploadTime;
	}

	public String getDocPath() {
		return this.docPath;
	}

	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}

	public Boolean getAvailable() {
		return this.available;
	}

	public void setAvailable(Boolean available) {
		this.available = available;
	}

	public Float getVersion() {
		return this.version;
	}

	public void setVersion(Float version) {
		this.version = version;
	}

	public Integer getOriginalDocId() {
		return originalDocId;
	}

	public void setOriginalDocId(Integer originalDocId) {
		this.originalDocId = originalDocId;
	}

}