FROM inetsoftware/alpine-tesseract as builder

RUN mkdir -p /tesseract/tessdata-lng
RUN wget -q 'https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata' -O /tesseract/tessdata-lng/eng.traineddata
RUN wget -q 'https://github.com/tesseract-ocr/tessdata/raw/master/rus.traineddata' -O /tesseract/tessdata-lng/rus.traineddata
RUN wget -q 'https://github.com/tesseract-ocr/tessdata/raw/master/osd.traineddata' -O /tesseract/tessdata-lng/osd.traineddata

FROM alpine:3.8.4

ENV LC_ALL C

# add required tessdata
RUN mkdir -p /usr/share/tessdata

# copy the packages
COPY --from=builder /tesseract/tesseract-git-* /tesseract/

COPY --from=builder /tesseract/tessdata-lng/* /usr/share/tessdata/

RUN set -x \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update --allow-untrusted /tesseract/tesseract-git-* \
    && rm  -rf /tesseract \
    && echo "done"

WORKDIR /runner
COPY . .

