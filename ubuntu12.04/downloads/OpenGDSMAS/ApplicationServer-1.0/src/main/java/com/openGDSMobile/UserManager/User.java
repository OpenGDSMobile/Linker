package com.openGDSMobile.UserManager;

public class User {
	private String userId;
	private String passwd;
	private String username;
	private String email;
	

	public User(String userId, String passwd, String username, String email){
		super();
		this.userId = userId;
		this.passwd = passwd;
		this.username = username;
		this.email = email;
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public User(){
		super();
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [userId=");
		builder.append(userId);
		builder.append(", passwd=");
		builder.append(passwd);
		builder.append(", username=");
		builder.append(username);
		builder.append(", email=");
		builder.append(email);
		builder.append("]");
		return builder.toString();
	}

	

}
