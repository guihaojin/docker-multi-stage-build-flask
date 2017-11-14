FROM ubuntu:latest as build
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt

FROM python:3-alpine
COPY --from=build /root/.cache /root/.cache
COPY --from=build /app/requirements.txt .
COPY --from=build /app .
RUN pip install -r requirements.txt && rm -rf /root/.cache
ENTRYPOINT ["python"]
CMD ["app.py"]
