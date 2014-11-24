package com.openGDSMobile.UserManager;

public interface UserService {

	boolean insert(User u);
	User login(String userId, String password);
	User selectUser(String userId);
	boolean delete(String userId);
	
}
