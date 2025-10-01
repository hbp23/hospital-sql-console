public class Query {
    private final String q;
    private final String description;

    public Query(String q, String description) {
        this.q = q;
        this.description = description;
    }

    public String getQ() { return this.q; }
    public String getDescription() { return this.description; }
}
