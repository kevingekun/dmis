package lab.dmis.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Doc entity. @author MyEclipse Persistence Tools
 */

public class Doc implements java.io.Serializable {

	// Fields

	private Integer id;
	private Type type;
	private User user;
	private String title;
	private String author;
	private String brief;
	private Timestamp uploadTime;
	private Integer downloadTimes;
	private String docPath;
	private Float version;
	private String journal;
	private String publishedTime;
	private String category;
	private Integer language;
	private String format;
	private Boolean isPass;
	private Integer level;
	private Integer originalId;
	private Set downloadrecoders = new HashSet(0);
	private Set keyworddocs = new HashSet(0);
	private Set comments = new HashSet(0);

	public String getFilename() {
		String fileName = this.docPath
				.substring(this.docPath.lastIndexOf("/") + 1);

		return fileName;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Type getType() {
		return this.type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getBrief() {
		return brief;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	public Timestamp getUploadTime() {
		return this.uploadTime;
	}

	public void setUploadTime(Timestamp uploadTime) {
		this.uploadTime = uploadTime;
	}

	public Integer getDownloadTimes() {
		return this.downloadTimes;
	}

	public void setDownloadTimes(Integer downloadTimes) {
		this.downloadTimes = downloadTimes;
	}

	public String getDocPath() {
		return this.docPath;
	}

	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}

	public Float getVersion() {
		return this.version;
	}

	public void setVersion(Float version) {
		this.version = version;
	}

	public String getJournal() {
		return this.journal;
	}

	public void setJournal(String journal) {
		this.journal = journal;
	}

	public String getPublishedTime() {
		return this.publishedTime;
	}

	public void setPublishedTime(String publishedTime) {
		this.publishedTime = publishedTime;
	}

	public String getCategory() {
		return this.category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Integer getLanguage() {
		return this.language;
	}

	public void setLanguage(Integer language) {
		this.language = language;
	}

	public String getFormat() {
		return this.format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public Boolean getIsPass() {
		return this.isPass;
	}

	public void setIsPass(Boolean isPass) {
		this.isPass = isPass;
	}

	public Set getDownloadrecoders() {
		return this.downloadrecoders;
	}

	public void setDownloadrecoders(Set downloadrecoders) {
		this.downloadrecoders = downloadrecoders;
	}

	public Set getKeyworddocs() {
		return this.keyworddocs;
	}

	public void setKeyworddocs(Set keyworddocs) {
		this.keyworddocs = keyworddocs;
	}

	public Set getComments() {
		return this.comments;
	}

	public void setComments(Set comments) {
		this.comments = comments;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getOriginalId() {
		return originalId;
	}

	public void setOriginalId(Integer originalId) {
		this.originalId = originalId;
	}

}