package TMDTNoiThat.dao;

import java.util.List;

import TMDTNoiThat.entity.Comment;
import TMDTNoiThat.entity.User;

public interface CommentDao {
	List<Comment> getProductComments(Integer idProduct);
	Long countProductComments(Integer idProduct);
	
	boolean addProductComment(User user, Integer idProduct, String comment, Integer rating);
}
