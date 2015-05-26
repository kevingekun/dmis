package lab.dmis.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Doc implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private String author;
	private String brief;
	private String category;
	private String docPath;
	private Integer downloadTimes;
	private String format;
	private Integer id;
	private Boolean isPass;
	private String journal;
	private Set<Keyword> keywords = new HashSet<Keyword>();
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

	public Boolean getIsPass() {
		return this.isPass;
	}

	public String getJournal() {
		return this.journal;
	}

	@ManyToMany(mappedBy = "docs")
	public Set<Keyword> getKeywords() {
		return keywords;
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

	public void setFormat(String format) {
		this.format = format;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setIsPass(Boolean isPass) {
		this.isPass = isPass;
	}

	public void setJournal(String journal) {
		this.journal = journal;
	}

	public void setKeywords(Set<Keyword> keywords) {
		this.keywords = keywords;
	}

	public void setLanguage(Integer language) {
		this.language = language;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

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