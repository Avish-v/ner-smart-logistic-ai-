@echo off
REM PostgreSQL Database Setup for NER Logistics SIH 2026

cls
echo.
echo ========================================================
echo PostgreSQL Database Setup for NER Logistics
echo ========================================================
echo.

echo Step 1: Testing PostgreSQL connection...
psql -U postgres -c "SELECT 1;" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] PostgreSQL is running
) else (
    echo [ERROR] Cannot connect to PostgreSQL
    echo Make sure PostgreSQL is running on port 5432
    pause
    exit /b 1
)

echo.
echo Step 2: Creating database 'ner_logistics'...
psql -U postgres -c "CREATE DATABASE ner_logistics;" 2>&1 | findstr /V "CREATE DATABASE" >nul && (
    echo [OK] Database created (or already exists)
) || (
    echo [OK] Database ready
)

echo.
echo Step 3: Testing connection to ner_logistics...
psql -U postgres -d ner_logistics -c "SELECT current_database();" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Connection successful!
) else (
    echo [ERROR] Connection failed
    pause
    exit /b 1
)

echo.
echo ========================================================
echo Spring Boot Configuration (already set):
echo ========================================================
echo URL:      jdbc:postgresql://localhost:5432/ner_logistics
echo User:     postgres
echo Password: set DB_PASSWORD before starting the application
echo.

echo ========================================================
echo NEXT STEPS
echo ========================================================
echo.
echo 1. Navigate to project directory:
echo    cd "d:\ner-logistic (1)\ner-logistic"
echo.
echo 2. Build Spring Boot application:
echo    mvn clean install
echo.
echo 3. Run Spring Boot application:
echo    mvn spring-boot:run
echo.
echo 4. Test REST API (once running):
echo    curl http://localhost:8080/
echo.
echo Setup complete! Ready to run Spring Boot.
echo.
pause
