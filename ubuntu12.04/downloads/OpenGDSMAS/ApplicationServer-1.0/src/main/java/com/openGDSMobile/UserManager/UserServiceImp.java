package com.openGDSMobile.UserManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImp implements UserService {
	
	@Autowired
	@Qualifier("dao")
	UserDAO userdao; 
	

	@Transactional( propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED,
			timeout=10, readOnly=false, rollbackFor=java.lang.Exception.class) 
	@Override
	public boolean insert(User u) {
		// TODO Auto-generated method stub
		return userdao.insert(u);
	}
	
	@Override
	public User login(String userId, String password) {
		// TODO Auto-generated method stub
		return userdao.login(userId, password);
	}

	@Override
	public User selectUser(String userId) {
		// TODO Auto-generated method stub
		return userdao.selectUser(userId);
	}

	@Override
	public boolean delete(String userId) {
		// TODO Auto-generated method stub
		return userdao.delete(userId);
	}

}
