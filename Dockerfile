FROM rust:1.61.0

WORKDIR /app

RUN apt-get update && apt-get install lld clang -y

COPY . .

ENV SQLX_OFFLINE true

ENV APP_ENVIRONMENT production

RUN cargo build --release

ENTRYPOINT [ "./target/release/app" ]
