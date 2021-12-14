package TMDTNoiThat.services;

import java.util.List;

import TMDTNoiThat.entity.UserRole;

public interface UserRoleService {
	List<UserRole> getAllUserRoles();
	UserRole getUserRoleById(Integer idRole);
}
