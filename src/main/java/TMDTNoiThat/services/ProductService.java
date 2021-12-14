package TMDTNoiThat.services;

import java.math.BigDecimal;
import java.util.List;

import TMDTNoiThat.entity.Product;

public interface ProductService {
	List<Product> getProducts(Integer idCategory, String searchName, Integer sortType, int start, int count);
	Long countProducts(Integer idCategory, String searchName);
	
	List<Product> adminGetProducts(Integer idCategory, Integer status, Boolean outOfStock, int start, int count);
	Long adminCountProducts(Integer idCategory, Integer status, Boolean outOfStock);
	
	List<Product> sellerGetProducts(Integer idUser, Integer idCategory, Integer status, Boolean outOfStock, int start, int count);
	Long sellerCountProducts(Integer idUser, Integer idCategory, Integer status, Boolean outOfStock);
	
	List<Product> getTopNsoldProducts(Integer top);
	List<Product> getTopNvisitProducts(Integer top);
	List<Product> getTopNcommentProducts(Integer top);
	List<Product> getTopLastedProducts(Integer top);
	List<Product> getRandomProductsByCategory(Integer idCategory, Integer count, Integer exceptIdProduct);
	
	Product getProductById(Integer idProduct);
	
	boolean addProduct(Integer idCategory, String name, BigDecimal price, String description, Integer active, Integer availableQuantity, Integer idUser);
	boolean addProduct(Integer idCategory, String name, BigDecimal price, String description, Integer active, Integer availableQuantity, Integer idUser, List<String> imageLinks);
	boolean updateProduct(Integer idProduct, Integer idCategory, String name, BigDecimal price, String description, Integer nvisit, Integer nsold, Integer active, Integer availableQuantity);
	boolean updateNvisit(Integer idProduct, Integer nvisit);
	boolean deleteProduct(Integer idProduct);
	boolean setProductStatus(Integer idProduct, Integer active);
}
