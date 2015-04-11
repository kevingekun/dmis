package lab.dmis.model;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Keyword entity. @author MyEclipse Persistence Tools
 */

public class Keyword implements java.io.Serializable {

	// Fields

	private Integer id;
	private String keyword;
	private String content;
	private Boolean isPass;
	private Timestamp commitTime;
	private Timestamp passTime;
	private Set keyworddocs = new HashSet(0);

	// Constructors

	/** default constructor */
	public Keyword() {
	}

	/** minimal constructor */
	public Keyword(String keyword, String content, Boolean isPass,
			Timestamp commitTime, Timestamp passTime) {
		this.keyword = keyword;
		this.content = content;
		this.isPass = isPass;
		this.commitTime = commitTime;
		this.passTime = passTime;
	}

	/** full constructor */
	public Keyword(String keyword, String content, Boolean isPass,
			Timestamp commitTime, Timestamp passTime, Set keyworddocs) {
		this.keyword = keyword;
		this.content = content;
		this.isPass = isPass;
		this.commitTime = commitTime;
		this.passTime = passTime;
		this.keyworddocs = keyworddocs;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getKeyword() {
		return this.keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Boolean getIsPass() {
		return this.isPass;
	}

	public void setIsPass(Boolean isPass) {
		this.isPass = isPass;
	}

	public Timestamp getCommitTime() {
		return this.commitTime;
	}

	public void setCommitTime(Timestamp commitTime) {
		this.commitTime = commitTime;
	}

	public Timestamp getPassTime() {
		return this.passTime;
	}

	public void setPassTime(Timestamp passTime) {
		this.passTime = passTime;
	}

	public Set getKeyworddocs() {
		return this.keyworddocs;
	}

	public void setKeyworddocs(Set keyworddocs) {
		this.keyworddocs = keyworddocs;
	}

}