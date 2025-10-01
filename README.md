# Hospital SQL Console

## Overview
Hospital SQL Console is a command-line Java application that allows users to execute a curated set of SQL queries against a hospital database (Checkpoint4DB). The application leverages JDBC for database connectivity and loads all queries from an external file (`resources/sql/Checkpoint3.sql`). Users interact via a menu-driven CLI to select and run queries, with results formatted for clarity.

## Features
- **21 curated SQL queries**, grouped into the following categories:
  - **Room Utilization**
  - **Patient Information**
  - **Diagnosis & Treatment**
  - **Employee Information**
- **20 menu options:** Queries 3.1 and 3.2 share the same output and are presented as a single menu choice.
- **Reads queries from** `resources/sql/Checkpoint3.sql`.
- **Command-line interface:** Navigate and execute queries by number or type `exit` to quit.
- **Formatted output:** Results are clearly displayed in the terminal.
- **Robust error handling:** Exceptions are caught and clear feedback is provided.

## Tech Stack
- Java
- MySQL
- JDBC
- MySQL Connector/J
- CLI

## Requirements
- MySQL database server must be running and accessible.

## How to Run
1. **Clone the repository**
   ```sh
   git clone https://github.com/hbp23/hospital-sql-console.git
   cd hospital-sql-console
   ```
2. **Create the database**
   - Use the SQL script at `resources/sql/Checkpoint4DB.sql` to create and populate the `Checkpoint4DB` database in your MySQL server.
3. **Configure database variables**
   - Change DB_URL, DB_USER, and DB_PASSWORD to your database connection details:
4. **Compile the project**
   ```sh
   javac -d bin -cp "lib/*" src/*.java
   ```
5. **Run the application**
   ```sh
   java -cp "bin:lib/*" SQLApplication
   ```
6. **Using the CLI**
   - Enter the menu number for the query you wish to run, or type `exit` to quit.

## Project Structure
```
src/                 # Java source files
resources/sql/       # SQL scripts: Checkpoint3.sql (queries), Checkpoint4DB.sql (schema & data)
lib/                 # External library JARs (e.g., MySQL JDBC driver)
docs/                # Documentation (e.g., ER diagrams)
```

## Notes
- **Tested on:** IntelliJ IDEA and standard command-line environments.
- **Query 3.1 and 3.2:** These two queries share the same output and are combined into a single menu option.

---

## License
MIT License – see [LICENSE](LICENSE) for details.