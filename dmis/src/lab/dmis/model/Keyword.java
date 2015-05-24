package lab.dmis.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Keyword implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Timestamp commitTime;
	private String content;
	private Integer id;
	private Boolean isPass;
	// private Set<Keyworddoc> kds = new HashSet<Keyworddoc>();
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

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	public Boolean getIsPass() {
		return this.isPass;
	}

	/*
	 * @OneToMany(mappedBy = "keyword") public Set<Keyworddoc> getKds() { return
	 * kds; }
	 */

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

	public void setId(Integer id) {
		this.id = id;
	}

	public void setIsPass(Boolean isPass) {
		this.isPass = isPass;
	}

	/*
	 * public void setKds(Set<Keyworddoc> kds) { this.kds = kds; }
	 */

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public void setPassTime(Timestamp passTime) {
		this.passTime = passTime;
	}

}