FROM golang:alpine AS builder

RUN apk add --no-cache upx

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o fullcycle main.go

RUN upx --best fullcycle

FROM scratch
COPY --from=builder /app/fullcycle /fullcycle
ENTRYPOINT ["/fullcycle"]