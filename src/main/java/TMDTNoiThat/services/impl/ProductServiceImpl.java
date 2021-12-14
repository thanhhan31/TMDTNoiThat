package TMDTNoiThat.services.impl;

import java.math.BigDecimal;
import java.util.List;

import TMDTNoiThat.dao.ProductDao;
import TMDTNoiThat.dao.impl.ProductDaoImpl;
import TMDTNoiThat.entity.Product;
import TMDTNoiThat.services.ProductService;

public class ProductServiceImpl implements ProductService {
	ProductDao p = new ProductDaoImpl();
	
	@Override
	public List<Product> getProducts(Integer idCategory, String searchName, Integer sortType, int start, int count) {
		return p.getProducts(idCategory, searchName, sortType, start, count);
	}
	
	@Override
	public Long countProducts(Integer idCategory, String searchName) {
		return p.countProducts(idCategory, searchName);
	}
	
	@Override
	public List<Product> adminGetProducts(Integer idCategory, Integer status, Boolean outOfStock, int start, int count) {
		return p.sellerGetProducts(null, idCategory, status, outOfStock, start, count);
	}

	@Override
	public Long adminCountProducts(Integer idCategory, Integer status, Boolean outOfStock) {
		return p.sellerCountProducts(null, idCategory, status, outOfStock);
	}
	
	@Override
	public List<Product> sellerGetProducts(Integer idUser, Integer idCategory, Integer status, Boolean outOfStock, int start, int count) {
		return p.sellerGetProducts(idUser, idCategory, status, outOfStock, start, count);
	}

	@Override
	public Long sellerCountProducts(Integer idUser, Integer idCategory, Integer status, Boolean outOfStock) {
		return p.sellerCountProducts(idUser, idCategory, status, outOfStock);
	}
	
	@Override
	public List<Product> getTopNsoldProducts(Integer top) {
		return p.getTopNsoldProducts(top);
	}

	@Override
	public List<Product> getTopNvisitProducts(Integer top) {
		return p.getTopNvisitProducts(top);
	}

	@Override
	public List<Product> getTopNcommentProducts(Integer top) {
		return p.getTopNcommentProducts(top);
	}
	
	@Override
	public List<Product> getTopLastedProducts(Integer top) {
		return p.getTopLastedProducts(top);
	}

	@Override
	public List<Product> getRandomProductsByCategory(Integer idCategory, Integer count, Integer exceptIdProduct) {
		return p.getRandomProductsByCategory(idCategory, count, exceptIdProduct);
	}

	@Override
	public Product getProductById(Integer idProduct) {
		return p.getProductById(idProduct);
	}
	
	@Override
	public boolean addProduct(Integer idCategory, String name, BigDecimal price, String description, Integer active, Integer availableQuantity, Integer idUser) {
		return p.addProduct(idCategory, name, price, description, active, availableQuantity, idUser, null);
	}

	@Override
	public boolean addProduct(Integer idCategory, String name, BigDecimal price, String description, Integer active, Integer availableQuantity, Integer idUser, List<String> imageLinks) {
		return p.addProduct(idCategory, name, price, description, active, availableQuantity, idUser, imageLinks);
	}

	@Override
	public boolean updateProduct(Integer idProduct, Integer idCategory, String name, BigDecimal price, String description, Integer nvisit, Integer nsold, Integer active, Integer availableQuantity) {
		return p.updateProduct(idProduct, idCategory, name, price, description, nvisit, nsold, active, availableQuantity);
	}	

	@Override
	public boolean updateNvisit(Integer idProduct, Integer nvisit) {
		return p.updateProduct(idProduct, null, null, null, null, nvisit, null, null, null);
	}
	
	@Override
	public boolean deleteProduct(Integer idProduct) {
		return p.deleteProduct(idProduct);
	}
	
	@Override
	public boolean setProductStatus(Integer idProduct, Integer active) {
		return p.updateProduct(idProduct, null, null, null, null, null, null, active, null);
	}
}
