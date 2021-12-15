package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.UserDao;
import TMDTNoiThat.dao.impl.UserDaoImpl;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.UserService;

public class UserServiceImpl implements UserService {
	UserDao u = new UserDaoImpl();
	
	@Override
	public List<User> getUsers(Integer idRole, Boolean active, Integer start, Integer count) {
		return u.getUsers(idRole, active, start, count);
	}

	@Override
	public Long countUsers(Integer idRole, Boolean active) {
		return u.countUsers(idRole, active);
	}
	
	@Override
	public User getUser(Integer idUser) {
		return u.getUser(idUser);
	}

	@Override
	public User getUser(String email, String password) {
		return u.getUser(email, password);
	}

	@Override
	public int createUser(Integer idRole, String username, String password, String phone, String email, String avatar, Boolean active) {
		if (u.checkEmailExists(email))
			return 1;
		else if (u.checkPhoneExists(phone))
			return 2;
		
		if(u.createUser(idRole, username, password, phone, email, avatar, active))
			return 0;
		else
			return -1;
	}
	
	@Override
	public boolean updateUser(Integer idUser, Integer idRole, String username, String password, String phone, String email, String avatar, Boolean active) {
		return u.updateUser(idUser, idRole, username, password, phone, email, avatar, active);
	}

	@Override
	public boolean checkPhoneExists(String phone) {
		return u.checkPhoneExists(phone);
	}

	@Override
	public boolean checkEmailExists(String email) {
		return u.checkEmailExists(email);
	}
}
