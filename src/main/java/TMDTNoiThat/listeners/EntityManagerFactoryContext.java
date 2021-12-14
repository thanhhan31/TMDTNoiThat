package TMDTNoiThat.listeners;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class EntityManagerFactoryContext implements ServletContextListener {
	/*private*/ public static EntityManagerFactory emf;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		emf = Persistence.createEntityManagerFactory("TMDTNoiThat");
        context.setAttribute("emf", emf);
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		emf.close();
	}
	
	public static EntityManager createEntityManager () {
        return emf.createEntityManager();
    }
}
