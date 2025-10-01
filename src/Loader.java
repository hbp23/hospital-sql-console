import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Loader {
    private static final String DBQuery_FILE_PATH = "resources/sql/Checkpoint3.sql";

    public static LinkedHashMap<String, String> loadDBQueries() {
        LinkedHashMap<String, String> queryMap = new LinkedHashMap<>();
        try {
            String queriesFile = Files.readString(Paths.get(DBQuery_FILE_PATH));
            Pattern pattern = Pattern.compile("--\\s*Query\\s*(\\d+\\.\\d*):\\s*(.*?)\\n(.*?);", Pattern.DOTALL);
            Matcher matcher = pattern.matcher(queriesFile);
            while (matcher.find()) {
                String description = matcher.group(2).trim();
                String q = matcher.group(3).trim();
                queryMap.put(q, description);
            }
        } catch (IOException e) {
            System.err.println("Error loading DB queries from file: " + e.getMessage());
        }
        return queryMap;
    }
}
