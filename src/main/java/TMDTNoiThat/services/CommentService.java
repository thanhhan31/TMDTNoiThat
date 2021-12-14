package TMDTNoiThat.services;

import java.util.List;

import TMDTNoiThat.entity.Comment;
import TMDTNoiThat.entity.User;

public interface CommentService {
	List<Comment> getProductComments(Integer idProduct);
	Long countProductComments(Integer idProduct);
	
	boolean addProductComment(User user, Integer idProduct, String comment, Integer rating);
}
