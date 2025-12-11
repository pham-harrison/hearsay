# HearSay

HearSay is a social podcast review platform where users can rate podcast episodes, follow friends, and explore their friends' listening activity. This project is built with **TypeScript**, **React**, **Tailwind CSS**, **Python**, **FastAPI**, and **MySQL**.

## Getting Started

### 1. Clone the repository

```
git clone https://github.com/<your-username>/hearsay.git
```

### 2. Set up the database
Run the SQL script:
```
database/hearsay_db.sql
```
in MySQL Workbench (or your preferred MySQL client).

### 3. Navigate to the project root in the terminal

```
cd hearsay
```

### 4. Create a `.env` file in the project root
Include your MySQL user credentials:
```
HOST=localhost
DB_USER=<your username here>
DB_PASSWORD=<your password here>
DATABASE=hearsay_db
JWT_SECRET="sIxSeVeNsIxSeVeNsIxSeVeN"
JWT_ALGORITHM="HS256"
JWT_EXPIRE_MINUTES=67
```

### 5. Create and activate a virtual environment
*Windows Powershell:*
```
python -m venv .venv
.venv\Scripts\Activate.ps1
```

*macOS / Linux:*
```
python3 -m venv .venv
. ./.venv/bin/activate
```

### 6. Install backend dependencies

```
pip install --upgrade pip
pip install -r backend/requirements.txt
```

### 7. Run the FastAPI server
*Windows Powershell:*
```
.\.venv\Scripts\uvicorn.exe backend.main:app --reload
```

*macOS / Linux:*
```
.\.venv\bin\uvicorn backend.main:app --reload
```

### 8. In a second terminal, navigate to the frontend directory

```
cd frontend
```

### 9. Create a `.env` file for the frontend

```
VITE_API_URL=http://127.0.0.1:8000
```

### 10. Install the frontend dependencies

```
npm install
```

### 11. Start the frontend development server

```
npm run dev
```

### 12. Run the application

```
http://localhost:5173/
```

You should now be on the HearSay home page and ready to use the application.
