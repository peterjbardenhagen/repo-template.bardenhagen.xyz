# Python Project Seed

Use this seed when creating a new Python project from the template.

## Files to Add After Init

```bash
python -m venv .venv
pip install fastapi uvicorn pytest httpx
pip freeze > requirements.txt
```

## Template Notes

- `AI_CONTEXT.md` — Update stack to "Python / FastAPI / Python 3.11+"
- `.gitignore` — Handles __pycache__/, .venv/, *.pyc
- `docker-compose.yml` — Adjust for Python service
