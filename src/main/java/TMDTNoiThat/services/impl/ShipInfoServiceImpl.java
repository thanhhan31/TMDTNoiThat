package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.ShipInfoDao;
import TMDTNoiThat.dao.impl.ShipInfoDaoImpl;
import TMDTNoiThat.entity.ShipInfo;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.ShipInfoService;

public class ShipInfoServiceImpl implements ShipInfoService {
	ShipInfoDao s = new ShipInfoDaoImpl();
	
	@Override
	public List<ShipInfo> getUserShipInfos(Integer idUser) {
		return s.getUserShipInfos(idUser);
	}
	
	@Override
	public Long countUserShipInfos(Integer idUser) {
		return s.countUserShipInfos(idUser);
	}
	
	@Override
	public ShipInfo getShipInfosInfoById(Integer idShip) {
		return s.getShipInfosInfoById(idShip);
	}

	@Override
	public boolean addUserShipInfo(User user, String address) {
		return s.addUserShipInfo(user, address);
	}

	@Override
	public boolean updateUserShipInfo(Integer idShip, String address) {
		return s.updateUserShipInfo(idShip, address);
	}

	@Override
	public boolean deleteUserShipInfo(Integer idShip) {
		return s.deleteUserShipInfo(idShip);
	}
}
