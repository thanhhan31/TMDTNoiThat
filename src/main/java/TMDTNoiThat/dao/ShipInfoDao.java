package TMDTNoiThat.dao;

import java.util.List;

import TMDTNoiThat.entity.ShipInfo;
import TMDTNoiThat.entity.User;

public interface ShipInfoDao {
	List<ShipInfo> getUserShipInfos(Integer idUser);
	Long countUserShipInfos(Integer idUser);
	ShipInfo getShipInfosInfoById(Integer idShip);

	boolean addUserShipInfo(User user, String address);
	boolean updateUserShipInfo(Integer idShip, String address);
	boolean deleteUserShipInfo(Integer idShip);
}
