# Aktia QA Test Automation Project

## Overview
API test automation using Robotframework test for two endpoints
## Table of Contents
- Installation
- Usage
- Test Cases
- Running Tests
- Contributing
- License

## Installation
Step by Step guide in installing this project
```bash
# Clone the repository
git clone https://github.com/yourusername/yourproject.git

# Create a virtual environment
python -m venv venv

# Activate virtual environment
source venv/bin/activate (or equivalent on Windows)

# Install dependencies
pip install -r requirements.txt
```

## Running Tests

```bash
# Run in parralel tests with pabot
pabot --processes 4 --outputdir results --report report.html --log log.html tests/

# Run individual tests with tags [signup & login]
robot -i signup -d results tests/*.robot
robot -i login -d results tests/*.robot

# For windows users run tests from the run_tests.cmd file
run.cmd
```
## Reports

All test reports are located in the ./results directory



