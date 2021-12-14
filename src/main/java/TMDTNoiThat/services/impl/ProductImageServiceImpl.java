package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.ProductImageDao;
import TMDTNoiThat.dao.impl.ProductImageDaoImpl;
import TMDTNoiThat.entity.ProductImage;
import TMDTNoiThat.services.ProductImageService;

public class ProductImageServiceImpl implements ProductImageService {
	ProductImageDao pimg = new ProductImageDaoImpl();
	
	@Override
	public List<ProductImage> getProductImages(Integer idProduct) {
		return pimg.getProductImages(idProduct);
	}

	@Override
	public boolean addProductImage(Integer idProduct, String imageLink) {
		return pimg.addProductImage(idProduct, imageLink);
	}

	@Override
	public boolean deleteProductImage(Integer idProductImage) {
		return pimg.deleteProductImage(idProductImage);
	}
}
