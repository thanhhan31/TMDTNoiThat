package TMDTNoiThat.dao;

import java.util.List;

import TMDTNoiThat.entity.User;

public interface UserDao {
	List<User> getUsers(Integer idRole, String searchName, Boolean active, Integer start, Integer count);
	Long countUsers(Integer idRole, String searchName, Boolean active);
	User getUser(Integer idUser);
	User getUser(String email, String password);
	
	boolean createUser(Integer idRole, String username, String password, String phone, String email, String avatar, Boolean active);
	boolean updateUser(Integer idUser, Integer idRole, String username, String password, String phone, String email, String avatar, Boolean active);
	boolean checkEmailExists(String email);
	boolean checkPhoneExists(String phone);
}
