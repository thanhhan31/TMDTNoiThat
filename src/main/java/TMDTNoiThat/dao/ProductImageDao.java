package TMDTNoiThat.dao;

import java.util.List;

import TMDTNoiThat.entity.ProductImage;

public interface ProductImageDao {
	List<ProductImage> getProductImages(Integer idProduct);

	boolean addProductImage(Integer idProduct, String imageLink);
	boolean deleteProductImage(Integer idProductImage);
}
