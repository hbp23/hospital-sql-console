import java.util.LinkedHashMap;
import java.util.Scanner;

public class DBMenu {
    // Key is an SQL query and Value is the Description of it
    private LinkedHashMap<String, String> queryMap;

    public DBMenu(LinkedHashMap<String, String> queryMap) { this.queryMap = queryMap; }

    public void displayDBMenu() {
        Scanner scan = new Scanner(System.in);
        while (true) {
            System.out.println("Select an SQL query for execution or type 'exit': ");
            int queryNum = 1;
            for (String description : queryMap.values()) {
                System.out.println(queryNum + ". " + description);
                queryNum++;
            }
            String userInput = scan.nextLine();
            if (userInput.equalsIgnoreCase("exit")) {
                System.out.println("Exiting...");
                break;
            }
            try {
                int queryNumInput = Integer.parseInt(userInput);
                if (queryNumInput > 0 && queryNumInput <= queryMap.size()) {
                    String query = (String) queryMap.keySet().toArray()[queryNumInput - 1];
                    System.out.println("Executing Query: " + queryMap.get(query));
                    Executor.execute(query);
                    System.out.println("Query executed successfully");
                } else {
                    System.out.println("Invalid input. Please try again.");
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid input. Please try again with a valid number.");
            }

        }
        scan.close();
        System.out.println("Goodbye!");
    }
}
