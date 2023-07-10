FROM python:3.9-alpine3.13
LABEL maintainer="oreofe-stephen"

ENV PYTHONUNBUFFERED 1

COPY ./package.txt /tmp/package.txt
# COPY ./package.dev.txt /tmp/package.dev.txt
# COPY ./scripts /scripts
COPY ./appzone /appzone

WORKDIR /app
EXPOSE 8000

# ARG DEV=false

# Note: first creation of .venv before pip install
# creation of user1, total access for base user only 
RUN python -m venv /.venv && \
    /.venv/bin/pip install --upgrade pip && \
    # apk add --update --no-cache postgresql-client jpeg-dev && \
    # apk add --update --no-cache --virtual .tmp-build-deps \
    #     build-base postgresql-dev musl-dev zlib zlib-dev linux-headers && \
    /.venv/bin/pip install -r /tmp/package.txt && \
    # if [ $DEV = "true" ]; \
    #     then /py/bin/pip install -r /tmp/package.dev.txt ; \
    # fi && \
    rm -rf /tmp && \
    # apk del .tmp-build-deps && \
    adduser \
        --disabled-password \
        --no-create-home \
        user1
    #   django-user && \
    # mkdir -p /vol/web/media && \
    # mkdir -p /vol/web/static && \
    # chown -R django-user:django-user /vol && \
    # chmod -R 755 /vol && \
    # chmod -R +x /scripts

# Set location for all executables to run
ENV PATH="/.venv/bin:$PATH"

# Switch to user created
USER user1

# CMD ["run.sh"]