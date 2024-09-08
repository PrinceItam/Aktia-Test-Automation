@echo off
REM Run tests in parallel using Pabot
pabot --processes 4 --outputdir results --report report.html --log log.html --listener RetryFailed:1 tests/
pause