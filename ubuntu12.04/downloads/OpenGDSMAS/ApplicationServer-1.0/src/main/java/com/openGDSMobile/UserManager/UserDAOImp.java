package com.openGDSMobile.UserManager;
    
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
 


@Repository("dao") 
public class UserDAOImp  implements UserDAO {
	
	@Autowired
	SqlSessionTemplate sess;
	
	@Override
	public boolean insert(User u) {  
		int i = sess.insert("ump.insert",u);
		System.out.println(i); 
		if(i==1)	return true;
		else		return false;
	}

	@Override
	public User login(String userId, String password) {
		// TODO Auto-generated method stub
		User u = sess.selectOne("ump.select", userId); 
		if(u.getPasswd().equals(password))		return u;			
		else		return null;
	}

	@Override
	public User selectUser(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean delete(String userId) {
		// TODO Auto-generated method stub
		return false;
	}

}
