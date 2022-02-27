package ir.miladtehrany.check;

import java.sql.Connection;
import java.sql.DriverManager;

public class ProductsComponent {
    public boolean tryConnection() throws Exception {
        Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "milad", "myjava123");
        boolean isValid = connection.isValid(2);
        connection.close();
        return false;
    }
}
