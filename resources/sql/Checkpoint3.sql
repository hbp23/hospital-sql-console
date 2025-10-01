-- Query 1.1: List the rooms that are occupied, along with the associated patient names and the date the patient was admitted
SELECT r.room_number, p.first_name AS patient_first_name, p.last_name AS patient_last_name, a.admission_date
FROM Room r
JOIN Patient p ON r.patient_id = p.patient_id
JOIN Admission a ON p.patient_id = a.patient_id
WHERE a.discharge_date IS NULL;

-- Query 1.2: List the rooms that are currently unoccupied
SELECT r.room_number
FROM Room r
LEFT JOIN Admission a ON r.room_number = a.room_number AND a.discharge_date IS NULL
WHERE a.admission_id IS NULL;

-- Query 1.3: List all rooms in the hospital along with patient names and admission dates for those that are occupied
SELECT r.room_number, p.first_name AS patient_first_name, p.last_name AS patient_last_name, a.admission_date
FROM Room r
LEFT JOIN Patient p ON r.patient_id = p.patient_id
LEFT JOIN Admission a ON a.patient_id = p.patient_id AND a.discharge_date IS NULL;

-- Query 2.1: List all patients in the database, with full personal information
SELECT * FROM Patient;

-- Query 2.2: List all patients currently admitted to the hospital. List only patient identification number and name
SELECT p.patient_id, p.first_name AS patient_first_name, p.last_name AS patient_last_name
FROM Patient p
JOIN Admission a ON p.patient_id = a.patient_id
WHERE a.discharge_date IS NULL;

-- Query 2.3: List all patients who were discharged in a given date range. List only patient identification number and name
SELECT p.patient_id, p.first_name AS patient_first_name, p.last_name AS patient_last_name
FROM Patient p
JOIN Admission a ON p.patient_id = a.patient_id
WHERE a.discharge_date BETWEEN '2025-03-14' AND '2025-04-14';

-- Query 2.4: List all patients who were admitted within a given date range. List only patient identification number and name
SELECT p.patient_id, p.first_name AS patient_first_name, p.last_name AS patient_last_name
FROM Patient p
JOIN Admission a ON p.patient_id = a.patient_id
WHERE a.admission_date BETWEEN '2025-03-14' AND '2025-04-14';

-- Query 2.5: For a given patient (either patient identification number or name), list all admissions to the hospital along with the diagnosis for each admission
SELECT a.admission_id, d.diagnosis AS diagnosis, a.admission_date, a.discharge_date
FROM Admission a
JOIN Diagnosis d ON a.diagnosis_id = d.diagnosis_id
JOIN Patient p ON a.patient_id = p.patient_id
WHERE p.first_name = 'Henry' OR p.last_name = 'Patel' OR p.patient_id = 103;

-- Query 2.6: For a given patient (either patient identification number or name), list all treatments that were administered, grouped by admissions
SELECT a.admission_id, t.treatment_id, t.description, t.order_time
FROM Admission a
JOIN Treatment t ON a.admission_id = t.admission_id
JOIN Patient p ON a.patient_id = p.patient_id
WHERE p.first_name = 'Jen' OR p.last_name = 'Lopez' OR p.patient_id = 102;
ORDER BY a.admission_date DESC, t.order_time ASC;

-- Query 2.7: List patients who were admitted to the hospital within 30 days of their last discharge date
SELECT DISTINCT p.patient_id, p.first_name AS patient_first_name, p.last_name AS patient_last_name, d.diagnosis AS diagnosis, a1.primary_doctor
FROM Admission a1
JOIN Admission a2 ON a1.patient_id = a2.patient_id
JOIN Patient p ON p.patient_id = a1.patient_id
JOIN Diagnosis d ON a1.diagnosis_id = d.diagnosis_id
WHERE a1.admission_date BETWEEN a2.discharge_date AND DATE_ADD(a2.discharge_date, INTERVAL 30 DAY)
AND a1.admission_id != a2.admission_id;

-- Query 2.8: For each patient ever admitted, list total number of admissions, average duration, longest span, shortest span, and average span between admissions
SELECT a1.patient_id, p.first_name AS patient_first_name, p.last_name AS patient_last_name, COUNT(*) AS total_admissions,
ROUND(AVG(DATEDIFF(IFNULL(a1.discharge_date, CURDATE()), a1.admission_date)), 1) AS avg_duration,
MAX(DATEDIFF(a2.admission_date, a1.admission_date)) AS max_span,
MIN(DATEDIFF(a2.admission_date, a1.admission_date)) AS min_span,
ROUND(AVG(DATEDIFF(a2.admission_date, a1.admission_date)), 1) AS avg_span
FROM Admission a1
JOIN Patient p ON a1.patient_id = p.patient_id
LEFT JOIN Admission a2 ON a1.patient_id = a2.patient_id AND a2.admission_date > a1.admission_date
AND NOT EXISTS (
    SELECT 1 FROM Admission a3
    WHERE a3.patient_id = a1.patient_id
    AND a3.admission_date > a1.admission_date
    AND a3.admission_date < a2.admission_date
)
GROUP BY a1.patient_id, p.last_name;

-- Query 3.1: List the diagnoses given to patients, in descending order of occurrences
SELECT d.diagnosis_id, d.diagnosis AS diagnosis, COUNT(*) AS total_occurrences
FROM Admission a
JOIN Diagnosis d ON a.diagnosis_id = d.diagnosis_id
GROUP BY d.diagnosis_id, d.diagnosis
ORDER BY total_occurrences DESC;

-- Query 3.2: List the diagnoses given to hospital patients, in descending order of occurrences
SELECT d.diagnosis_id, d.diagnosis AS diagnosis, COUNT(*) AS total_occurrences
FROM Admission a
JOIN Diagnosis d ON a.diagnosis_id = d.diagnosis_id
GROUP BY d.diagnosis_id, d.diagnosis
ORDER BY total_occurrences DESC;

-- Query 3.3: List the treatments performed on admitted patients, in descending order of occurrences
SELECT t.treatment_id, t.description, COUNT(*) AS total_occurrences
FROM Treatment t
JOIN Treatment_Administration ta ON t.treatment_id = ta.treatment_id
GROUP BY t.treatment_id, t.description
ORDER BY total_occurrences DESC;

-- Query 3.4: List the diagnoses associated with patients who have the highest occurrences of admissions
SELECT d.diagnosis AS diagnosis, COUNT(*) AS total
FROM Admission a
JOIN Diagnosis d ON a.diagnosis_id = d.diagnosis_id
WHERE a.patient_id = (
    SELECT patient_id FROM Admission
    GROUP BY patient_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
GROUP BY d.diagnosis
ORDER BY total ASC;

-- Query 3.5: For a given treatment occurrence, list the patient name and the doctor who ordered the treatment
SELECT p.first_name AS patient_first_name, p.last_name AS patient_last_name, e.first_name AS doctor_first_name, e.last_name AS doctor_last_name
FROM Treatment t
JOIN Admission a ON t.admission_id = a.admission_id
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Employee e ON t.ordered_by_id = e.employee_id
WHERE t.treatment_id = 23;

-- Query 4.1: List all workers at the hospital, sorted ascending by last name, first name
SELECT last_name, first_name, role
FROM Employee
ORDER BY last_name ASC, first_name ASC;

-- Query 4.2: List the primary doctors of patients with a high admission rate (at least 4 admissions within a one-year timeframe)
SELECT a.primary_doctor
FROM Admission a
GROUP BY a.primary_doctor, YEAR(a.admission_date)
HAVING COUNT(*) >= 4;

-- Query 4.3: For a given doctor, list all associated diagnoses in descending order of occurrence
SELECT d.diagnosis AS diagnosis, COUNT(*) AS total_occurrences
FROM Admission a
JOIN Diagnosis d ON a.diagnosis_id = d.diagnosis_id
WHERE a.primary_doctor = 1352
GROUP BY d.diagnosis
ORDER BY total_occurrences DESC;

-- Query 4.4: For a given doctor, list all treatments that they ordered in descending order of occurrence
SELECT t.description, COUNT(*) AS total_orders
FROM Treatment t
WHERE t.ordered_by_id = 1352
GROUP BY t.description
ORDER BY total_orders DESC;

-- Query 4.5: List employees who have been involved in the treatment of every admitted patient
SELECT e.employee_id, e.first_name, e.last_name
FROM Employee e
WHERE e.employee_id IN (
    SELECT doctor_id
    FROM Patient_Doctors
    GROUP BY doctor_id
    HAVING COUNT(DISTINCT admission_id) = (
        SELECT COUNT(DISTINCT admission_id) FROM Admission
    )
);