import java.sql.*;

public class Executor {
    public static void execute(String currentQ) {
        try (Connection connection = DBConnection.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(currentQ)) {

            System.out.println("\nExecuting Query: " + currentQ);
            ResultSetMetaData metaData = resultSet.getMetaData();
            int columnCount = metaData.getColumnCount();
            System.out.println();
            for (int i = 1; i <= columnCount; i++) {
                System.out.printf("%-25s", metaData.getColumnName(i)); // 25 characters wide per column
            }
            System.out.println();
            for (int i = 1; i <= columnCount; i++) {
                System.out.print("-------------------------");
            }
            System.out.println();
            while (resultSet.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String value = resultSet.getString(i);
                    if (value == null) value = "NULL"; // Handle NULLs nicely
                    System.out.printf("%-25s", value);
                }
                System.out.println();
            }
            System.out.println();

        } catch (SQLException e) {
            System.err.println("Error executing query: " + e.getMessage());
        }
    }
}