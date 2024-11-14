FROM python:3.11-slim

WORKDIR /app

COPY . .
COPY . /app

RUN pip install -r requirements.txt

# COPY /model/yolov8l-face.pt /app/model/

EXPOSE 8080

HEALTHCHECK CMD curl --fail http://localhost:8080/_stcore/health

# google cloud run deploy requires port=8080 
ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8080", "--server.address=0.0.0.0"]

# postpone gemini-api:app until finding out how to run both commands
# CMD ["uvicorn", "gemini-api:app", "--reload"]