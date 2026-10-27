# SmartCare Hospital Management System — Tomcat 9, No Database

## Requirements
- JDK 8 or newer (JDK 11/17 recommended)
- Apache Tomcat 9.x
- Maven 3.6+
- Eclipse IDE for Enterprise Java and Web Developers (optional)

## Run in Eclipse
1. Extract this ZIP.
2. Import the extracted folder using **File → Import → Existing Maven Projects**.
3. Make sure the project uses a Java 8+ JDK and a **Tomcat 9** server runtime.
4. Run `mvn clean package` from the project folder.
5. Copy `target/SmartCare.war` into Tomcat's `webapps` folder, or use **Run on Server** in Eclipse.
6. Open `http://localhost:8080/SmartCare/`.

## Demo accounts
- Admin: `admin@smartcare.test` / `Admin123!`
- Doctor: `doctor@smartcare.test` / `Doctor123!`
- Patient: `patient@smartcare.test` / `Patient123!`

You can also register a new patient from the website.

## No database
This version does not use MySQL, JDBC, database drivers, or SQL scripts. Demo users, doctors, and appointments are held in server memory and reset when Tomcat restarts. Do not use real patient information. Password storage is simplified for this classroom demo and is not suitable for production.

## Included
- Responsive homepage, login and registration
- Role-based session login for admin, doctor, and patient
- Admin dashboard with appointment management
- Doctor dashboard with appointment list and completion action
- Patient dashboard and appointment booking
- Servlet filters for encoding and route authorization
- Tomcat 9 compatible `javax.servlet` APIs
