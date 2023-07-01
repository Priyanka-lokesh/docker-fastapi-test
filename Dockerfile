FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8

COPY ./app /app/app

RUN pip install --no-cache-dir fastapi

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

