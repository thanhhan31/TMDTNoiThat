package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.UserRoleDao;
import TMDTNoiThat.dao.impl.UserRoleDaoImpl;
import TMDTNoiThat.entity.UserRole;
import TMDTNoiThat.services.UserRoleService;

public class UserRoleServiceImpl implements UserRoleService {
	UserRoleDao ur = new UserRoleDaoImpl();
	
	@Override
	public List<UserRole> getAllUserRoles() {
		return ur.getAllUserRoles();
	}

	@Override
	public UserRole getUserRoleById(Integer idRole) {
		return ur.getUserRoleById(idRole);
	}
}
