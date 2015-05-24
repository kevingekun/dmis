package lab.dmis.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Doc implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String author;
	private String brief;
	private String category;
	// private Set<Comment> comments = new HashSet<Comment>();
	private String docPath;
	// private Set<Downloadrecoder> downloadrecoders = new
	// HashSet<Downloadrecoder>();
	private Integer downloadTimes;
	private String format;
	private Integer id;
	private Boolean isPass;
	private String journal;
	// private Set<Keyworddoc> kds = new HashSet<Keyworddoc>();
	private Integer language;
	private Integer level;
	private String publishedTime;
	private String title;
	private Type type;
	private String typeName;
	private Timestamp uploadTime;
	private User user;
	private Float version;

	public String getAuthor() {
		return this.author;
	}

	public String getBrief() {
		return brief;
	}

	public String getCategory() {
		return this.category;
	}

	@Column(nullable = false)
	public String getDocPath() {
		return this.docPath;
	}

	public Integer getDownloadTimes() {
		return this.downloadTimes;
	}

	@Column(nullable = false)
	public String getFormat() {
		return this.format;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	/*
	 * @OneToMany(mappedBy = "doc") public Set<Comment> getComments() { return
	 * this.comments; }
	 */

	/*
	 * public String getFilename() { String fileName = this.docPath
	 * .substring(this.docPath.lastIndexOf("/") + 1);
	 * 
	 * return fileName; }
	 */

	public Boolean getIsPass() {
		return this.isPass;
	}

	/*
	 * @OneToMany(mappedBy = "doc") public Set<Downloadrecoder>
	 * getDownloadrecoders() { return this.downloadrecoders; }
	 */

	public String getJournal() {
		return this.journal;
	}

	@Column(nullable = false)
	public Integer getLanguage() {
		return this.language;
	}

	public Integer getLevel() {
		return level;
	}

	public String getPublishedTime() {
		return this.publishedTime;
	}

	/*
	 * @OneToMany(mappedBy = "doc") public Set<Keyworddoc> getKds() { return
	 * kds; }
	 */

	@Column(nullable = false)
	public String getTitle() {
		return this.title;
	}

	@ManyToOne
	@JoinColumn(name = "typeId")
	public Type getType() {
		return this.type;
	}

	@Transient
	public String getTypeName() {
		return typeName;
	}

	@Column(nullable = false)
	public Timestamp getUploadTime() {
		return this.uploadTime;
	}

	@ManyToOne
	@JoinColumn(name = "userId")
	public User getUser() {
		return this.user;
	}

	public Float getVersion() {
		return this.version;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public void setBrief(String brief) {
		this.brief = brief;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}

	public void setDownloadTimes(Integer downloadTimes) {
		this.downloadTimes = downloadTimes;
	}

	/*
	 * public void setComments(Set<Comment> comments) { this.comments =
	 * comments; }
	 */

	public void setFormat(String format) {
		this.format = format;
	}

	/*
	 * public void setDownloadrecoders(Set<Downloadrecoder> downloadrecoders) {
	 * this.downloadrecoders = downloadrecoders; }
	 */

	public void setId(Integer id) {
		this.id = id;
	}

	public void setIsPass(Boolean isPass) {
		this.isPass = isPass;
	}

	public void setJournal(String journal) {
		this.journal = journal;
	}

	public void setLanguage(Integer language) {
		this.language = language;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	/*
	 * public void setKds(Set<Keyworddoc> kds) { this.kds = kds; }
	 */

	public void setPublishedTime(String publishedTime) {
		this.publishedTime = publishedTime;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public void setUploadTime(Timestamp uploadTime) {
		this.uploadTime = uploadTime;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setVersion(Float version) {
		this.version = version;
	}

}