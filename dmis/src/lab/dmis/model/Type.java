package lab.dmis.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Type implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Set<Doc> docs = new HashSet<Doc>();
	private Integer id;
	private Integer level;
	private String name;
	private Integer parentId;

	@OneToMany(mappedBy = "type")
	public Set<Doc> getDocs() {
		return this.docs;
	}

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	@Column(nullable = false)
	public Integer getLevel() {
		return this.level;
	}

	@Column(nullable = false)
	public String getName() {
		return this.name;
	}

	@Column(nullable = false)
	public Integer getParentId() {
		return this.parentId;
	}

	public void setDocs(Set<Doc> docs) {
		this.docs = docs;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

}