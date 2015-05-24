package lab.dmis.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@org.hibernate.annotations.Entity(dynamicInsert = true, dynamicUpdate = true)
public class Type implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	// private Set<Type> childrens = new HashSet<Type>();
	private Integer id;
	private Integer level;
	private String name;
	private Type parent;

	/*
	 * @OneToMany(mappedBy = "parent") public Set<Type> getChildrens() { return
	 * childrens; }
	 */

	@Id
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	@Column(nullable = false)
	public Integer getLevel() {
		return this.level;
	}

	@Column(nullable = false, unique = true)
	public String getName() {
		return this.name;
	}

	@ManyToOne
	@JoinColumn(name = "parentId")
	public Type getParent() {
		return parent;
	}

	/*
	 * public void setChildrens(Set<Type> childrens) { this.childrens =
	 * childrens; }
	 */

	public void setId(Integer id) {
		this.id = id;
	}

	/*
	 * @Column(nullable = false) public Integer getParentId() { return
	 * this.parentId; }
	 */

	public void setLevel(Integer level) {
		this.level = level;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setParent(Type parent) {
		this.parent = parent;
	}

	/*
	 * public void setParentId(Integer parentId) { this.parentId = parentId; }
	 */

}