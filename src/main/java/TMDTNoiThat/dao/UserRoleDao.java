package TMDTNoiThat.dao;

import java.util.List;

import TMDTNoiThat.entity.UserRole;

public interface UserRoleDao {
	List<UserRole> getAllUserRoles();
	UserRole getUserRoleById(Integer idRole);
}
