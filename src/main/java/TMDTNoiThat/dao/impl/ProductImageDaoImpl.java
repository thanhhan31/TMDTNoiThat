package TMDTNoiThat.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaDelete;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import TMDTNoiThat.dao.ProductImageDao;
import TMDTNoiThat.listeners.EntityManagerFactoryContext;
import TMDTNoiThat.entity.ProductImage;
import TMDTNoiThat.entity.ProductImage_;
import TMDTNoiThat.entity.Product_;

public class ProductImageDaoImpl implements ProductImageDao {

	@Override
	public List<ProductImage> getProductImages(Integer idProduct) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<ProductImage> cq = cb.createQuery(ProductImage.class);
		Root<ProductImage> rootEntry = cq.from(ProductImage.class);
		cq.select(rootEntry);
		cq.where(cb.equal(rootEntry.get(ProductImage_.product).get(Product_.id), idProduct));

		List<ProductImage> ret = em.createQuery(cq).getResultList();
		em.close();

		return ret;
	}

	@Override
	public boolean addProductImage(Integer idProduct, String imageLink) {
		EntityManager em = EntityManagerFactoryContext.createEntityManager();

		ProductImage pimg = new ProductImage();
		pimg.setProduct(new ProductDaoImpl().getProductById(idProduct));
		pimg.setImageLink(imageLink);
		
		try {
			em.getTransaction().begin();
			em.persist(pimg);
			em.getTransaction().commit();
			return true;
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		} finally {
			em.close();
		}
	}

	@Override
	public boolean deleteProductImage(Integer idProductImage) {
		boolean ret = false;
		EntityManager em = EntityManagerFactoryContext.createEntityManager();
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaDelete<ProductImage> d = cb.createCriteriaDelete(ProductImage.class);
		Root<ProductImage> rootEntry = d.from(ProductImage.class);
		d.where(cb.equal(rootEntry.get(ProductImage_.id), idProductImage));
		
		em.getTransaction().begin();
		if (em.createQuery(d).executeUpdate() != 0) {
			ret = true;
		}
		em.getTransaction().commit();
		em.close();
		
		return ret;
	}
}
