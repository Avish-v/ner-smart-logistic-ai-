#!/usr/bin/env powershell
# Setup PostgreSQL database for NER Logistics SIH 2026

Write-Host "`n╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  PostgreSQL Database Setup for NER Logistics       ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Step 1: Check PostgreSQL connection
Write-Host "Step 1: Testing PostgreSQL connection..." -ForegroundColor Yellow
try {
    $psqlCheck = psql -U postgres -c "\q" 2>&1
    Write-Host "✓ PostgreSQL is running" -ForegroundColor Green
} catch {
    Write-Host "✗ Cannot connect to PostgreSQL. Make sure it's running:" -ForegroundColor Red
    Write-Host "  - Restart PostgreSQL service" -ForegroundColor Gray
    Write-Host "  - Check if port 5432 is open" -ForegroundColor Gray
    exit 1
}

# Step 2: Create database
Write-Host "`nStep 2: Creating database 'ner_logistics'..." -ForegroundColor Yellow
$createDB = psql -U postgres -c "CREATE DATABASE ner_logistics;" 2>&1

if ($LASTEXITCODE -eq 0 -or $createDB -match "CREATE DATABASE") {
    Write-Host "✓ Database created successfully!" -ForegroundColor Green
} elseif ($createDB -match "already exists") {
    Write-Host "⚠ Database 'ner_logistics' already exists (skipping)" -ForegroundColor Yellow
} else {
    Write-Host "✗ Failed to create database" -ForegroundColor Red
    Write-Host "  Error: $createDB" -ForegroundColor Gray
}

# Step 3: Test connection to new database
Write-Host "`nStep 3: Testing connection to 'ner_logistics'..." -ForegroundColor Yellow
try {
    $testConn = psql -U postgres -d ner_logistics -c "SELECT current_database();" 2>&1
    Write-Host "✓ Connection successful!" -ForegroundColor Green
    Write-Host "  Database: $($testConn[-1])" -ForegroundColor Gray
} catch {
    Write-Host "✗ Connection failed" -ForegroundColor Red
}

# Step 4: Display connection string
Write-Host "`nStep 4: Spring Boot Configuration (already set in application.properties):" -ForegroundColor Yellow
Write-Host "  URL: jdbc:postgresql://localhost:5432/ner_logistics" -ForegroundColor Cyan
Write-Host "  User: postgres" -ForegroundColor Cyan
Write-Host "  Password: set DB_PASSWORD before starting the application" -ForegroundColor Cyan

# Step 5: Next steps
Write-Host "`n╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  NEXT STEPS                                        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

Write-Host "1. Build Spring Boot application:" -ForegroundColor Yellow
Write-Host "   cd d:\ner-logistic (1)\ner-logistic" -ForegroundColor Gray
Write-Host "   mvn clean install" -ForegroundColor Gray

Write-Host "`n2. Run Spring Boot application:" -ForegroundColor Yellow
Write-Host "   mvn spring-boot:run" -ForegroundColor Gray

Write-Host "`n3. Test REST API:" -ForegroundColor Yellow
Write-Host "   curl http://localhost:8080/api/..." -ForegroundColor Gray

Write-Host "`n4. View database in pgAdmin (optional):" -ForegroundColor Yellow
Write-Host "   http://localhost:5050" -ForegroundColor Gray

Write-Host "`n✨ Setup complete! Ready to run Spring Boot.`n" -ForegroundColor Green
