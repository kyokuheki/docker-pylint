FROM python:3-alpine as builder

RUN set -eux \
 && apk add gcc musl-dev \
 && pip3 install pylint pyflakes flake8

FROM python:3-alpine as production
LABEL maintainer Kenzo Okuda <kyokuheki@gmail.comt>

COPY --from=builder /usr/local/lib/python3.7/site-packages/ /usr/local/lib/python3.7/site-packages/
COPY --from=builder /usr/local/bin/pylint /usr/local/bin/pylint
COPY --from=builder /usr/local/bin/pyflakes /usr/local/bin/pyflakes
COPY --from=builder /usr/local/bin/flake8 /usr/local/bin/flake8

VOLUME ["/src"]
WORKDIR /src
CMD pylint
