# https://thesorauniverse.com/posts/kr/golang/making-golang-docker-img-best-practices/
FROM golang:alpine AS builder

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64
    
WORKDIR /build

COPY go.mod go.sum main.go ./

RUN go mod download

RUN go build -o main .

WORKDIR /dist

RUN cp /build/main .

FROM scratch

COPY --from=builder /dist/main .

ENTRYPOINT [ "/main" ]

# FROM node:22-alpine3.20

# /app 으로 이동 (cd 랑 비슷)
# WORKDIR /app

# 현재 경로의 모든 파일들을 root 로 이동 (현재 경로는 ./app)
# COPY package*.json .
# ci 는 install 과는 다르게 버전을 고정해서 패키지들을 설치함
# RUN ["npm", "ci"]

# 옛날 버전의 라이브러리를 위해서 수동으로 설정
# ENV NODE_ENV=production

# COPY . .
# EXPOSE 3090

# USER node
# CMD [ "npm", "start" ]

# 1. docker build 시간 단축하기
# 변동사항 많은 명령어는 아래에 적기