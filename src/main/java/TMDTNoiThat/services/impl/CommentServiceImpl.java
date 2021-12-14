package TMDTNoiThat.services.impl;

import java.util.List;

import TMDTNoiThat.dao.CommentDao;
import TMDTNoiThat.dao.impl.CommentDaoImpl;
import TMDTNoiThat.entity.Comment;
import TMDTNoiThat.entity.User;
import TMDTNoiThat.services.CommentService;

public class CommentServiceImpl implements CommentService {
	CommentDao c = new CommentDaoImpl();
	@Override
	public List<Comment> getProductComments(Integer idProduct) {
		return c.getProductComments(idProduct);
	}

	@Override
	public Long countProductComments(Integer idProduct) {
		return c.countProductComments(idProduct);
	}

	@Override
	public boolean addProductComment(User user, Integer idProduct, String comment, Integer rating) {
		return c.addProductComment(user, idProduct, comment, rating);
	}

}
