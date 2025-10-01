import java.util.LinkedHashMap;

public class SQLApplication {
    public static void main(String[] args) {
        LinkedHashMap<String, String> queryMap = Loader.loadDBQueries();
        DBMenu dbMenu = new DBMenu(queryMap);
        dbMenu.displayDBMenu();
    }
}
