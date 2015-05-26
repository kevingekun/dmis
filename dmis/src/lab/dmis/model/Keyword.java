package lab.dmis.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Keyword implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Timestamp commitTime;
	private String content;
	private Set<Doc> docs = new HashSet<Doc>();
	private Integer id;
	private Boolean isPass;
	private String keyword;
	private Timestamp passTime;

	@Column(nullable = false)
	public Timestamp getCommitTime() {
		return this.commitTime;
	}

	@Column(nullable = false)
	public String getContent() {
		return this.content;
	}

	@ManyToMany
	@JoinTable(name = "keyworddoc", joinColumns = @JoinColumn(name = "keywordId"), inverseJoinColumns = @JoinColumn(name = "docId"))
	public Set<Doc> getDocs() {
		return docs;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	public Boolean getIsPass() {
		return this.isPass;
	}

	@Column(nullable = false, unique = true)
	public String getKeyword() {
		return this.keyword;
	}

	public Timestamp getPassTime() {
		return this.passTime;
	}

	public void setCommitTime(Timestamp commitTime) {
		this.commitTime = commitTime;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setDocs(Set<Doc> docs) {
		this.docs = docs;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setIsPass(Boolean isPass) {
		this.isPass = isPass;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public void setPassTime(Timestamp passTime) {
		this.passTime = passTime;
	}

}