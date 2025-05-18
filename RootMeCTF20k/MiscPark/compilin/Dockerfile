FROM python:3.12-alpine
EXPOSE 1337

RUN apk add --no-cache build-base
RUN pip install Flask

RUN addgroup -S challenge && adduser -S challenge -G challenge -h /challenge

COPY ./flag.txt /flag.txt
WORKDIR /challenge
COPY ./app ./
RUN chown -R root:challenge . && chmod -R 750 .
USER challenge

CMD python app.py