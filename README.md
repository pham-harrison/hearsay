# HearSay

HearSay is a social podcast rating platform where users can rate podcast episodes, follow friends, and explore their friends' listening activity. This project is built with **Python**, **FastAPI** and **MySQL**.

## Getting Started

### 1. Clone the repository

```
git clone https://github.com/<your-username>/hearsay.git
cd hearsay
```

### 2. Create and activate a virtual environment

```
# Windows PowerShell
python -m venv .venv
.venv\Scripts\Activate.ps1

# macOS / Linux
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install backend dependencies

```
pip install --upgrade pip
pip install -r backend/requirements.txt
```

### 4. Run the FastAPI server

```
uvicorn backend.main:app --reload
```
