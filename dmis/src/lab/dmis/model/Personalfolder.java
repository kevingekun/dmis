package lab.dmis.model;

/**
 * Personalfolder entity. @author MyEclipse Persistence Tools
 */

public class Personalfolder implements java.io.Serializable {

	// Fields

	private Integer id;
	private User user;
	private String fileName;
	private String path;

	// Constructors

	/** default constructor */
	public Personalfolder() {
	}

	/** full constructor */
	public Personalfolder(User user, String fileName, String path) {
		this.user = user;
		this.fileName = fileName;
		this.path = path;
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

	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}

}