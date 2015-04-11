package lab.dmis.model;

/**
 * Searchhistory entity. @author MyEclipse Persistence Tools
 */

public class Searchhistory implements java.io.Serializable {

	// Fields

	private Integer id;
	private User user;
	private String name;
	private Integer searchTimes;

	// Constructors

	/** default constructor */
	public Searchhistory() {
	}

	/** full constructor */
	public Searchhistory(User user, String name, Integer searchTimes) {
		this.user = user;
		this.name = name;
		this.searchTimes = searchTimes;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSearchTimes() {
		return this.searchTimes;
	}

	public void setSearchTimes(Integer searchTimes) {
		this.searchTimes = searchTimes;
	}

}