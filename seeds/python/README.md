# Python Project Seed

Use this seed when creating a new Python project from the template.

## Files to Add After Init

```bash
python -m venv .venv
pip install fastapi uvicorn pytest httpx
pip freeze > requirements.txt
```

## Template Integration Checklist

- [ ] Run `bash scripts/init-project.sh <project-name>` or use GitHub template clone
- [ ] `python -m venv .venv && source .venv/bin/activate`
- [ ] `pip install fastapi uvicorn pytest ruff`
- [ ] Create `src/` or `app/` package directory
- [ ] Update `AI_CONTEXT.md` — stack to "Python / FastAPI / Python 3.12+"
- [ ] Update `docs/architecture.md` — document service layers, routers, DTOs
- [ ] Add `.env` variables to `.env.example` (DATABASE_URL, CORS_ORIGINS, etc.)
- [ ] Configure `docker-compose.yml` for local Postgres / Redis
- [ ] Create `pyproject.toml` or `requirements-dev.txt` for test deps

## Recommended Packages

| Purpose | Package |
|---------|---------|
| Web framework | `fastapi` |
| ASGI server | `uvicorn` |
| Validation | `pydantic` |
| Testing | `pytest`, `pytest-asyncio`, `httpx` |
| Linting | `ruff` |
| Auth | `python-jose` + `passlib` |
| Database ORM | `sqlalchemy` + `alembic` |
