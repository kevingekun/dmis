package lab.dmis.model;

import java.util.HashSet;
import java.util.Set;

/**
 * Type entity. @author MyEclipse Persistence Tools
 */

public class Type implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private Integer level;
	private Integer parentId;
	private Set docs = new HashSet(0);

	// Constructors

	/** default constructor */
	public Type() {
	}

	/** minimal constructor */
	public Type(String name, Integer level, Integer parentId) {
		this.name = name;
		this.level = level;
		this.parentId = parentId;
	}

	/** full constructor */
	public Type(String name, Integer level, Integer parentId, Set docs) {
		this.name = name;
		this.level = level;
		this.parentId = parentId;
		this.docs = docs;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public Set getDocs() {
		return this.docs;
	}

	public void setDocs(Set docs) {
		this.docs = docs;
	}

}