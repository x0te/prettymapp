FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install --no-install-recommends -y \
    curl gdal-bin libgdal-dev g++ \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/streamlit-prettymapp

COPY streamlit-prettymapp /app/streamlit-prettymapp

RUN pip3 install -r streamlit-prettymapp/requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "streamlit-prettymapp/app.py", "--server.port=8501", "--server.address=0.0.0.0"]