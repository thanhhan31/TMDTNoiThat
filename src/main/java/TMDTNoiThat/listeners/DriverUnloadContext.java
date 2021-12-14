package TMDTNoiThat.listeners;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class DriverUnloadContext implements ServletContextListener {
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		Enumeration<Driver> drivers = DriverManager.getDrivers();
		while (drivers.hasMoreElements()) {
		    Driver driver = drivers.nextElement();
		    try {
		        DriverManager.deregisterDriver(driver);
		        //System.out.println("Deregistering jdbc driver: " + driver);
		    } catch (SQLException e) {
		    	e.printStackTrace();
		    }
		}
	}
}
