FROM inetsoftware/alpine-tesseract as builder

# dummy builder container

FROM alpine:3.8.4

ENV LC_ALL C

# add required tessdata
RUN mkdir -p /usr/share/tessdata
ADD https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata /usr/share/tessdata/eng.traineddata
ADD https://github.com/tesseract-ocr/tessdata/raw/master/rus.traineddata /usr/share/tessdata/rus.traineddata
ADD https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata /usr/share/tessdata/osd.traineddata

# copy the packages
COPY --from=builder /tesseract/tesseract-git-* /tesseract/

RUN set -x \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update --allow-untrusted /tesseract/tesseract-git-* \
    && rm  -rf /tesseract \
    && echo "done"

WORKDIR /app
