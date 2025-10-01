# Hospital Database SQL Project

## Overview
This project is a Java-based SQL query executor for a hospital database system. It loads queries from an external file (`Checkpoint3.sql`) and allows users to execute them from a menu interface.

## Features
- 21 pre-written SQL queries grouped into:
    - Room Utilization
    - Patient Information
    - Diagnosis & Treatment
    - Employee Information
- The menu only shows 20 options since Query 3.1 and 3.2 have the same output from my interpretation
- Reads queries from `resources/sql/Checkpoint3.sql`
- Executes them with formatted results in the terminal
- Handles exceptions and prints clear output

## How to Run
1. Open the project in IntelliJ.
2. Make sure `Checkpoint3.sql` is located at `resources/sql/Checkpoint3.sql`.
3. Make sure the database Checkpoint4DB is connected to Intelij.
4. Run `SQLApplication.java`.
5. Select a query from the menu by typing the number associated with the query in the new line.
6. Type 'exit' to quit the application.

## Author
Harsh Patel
CPSC 5130 – Checkpoint 4