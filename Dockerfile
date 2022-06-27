FROM lukemathwalker/cargo-chef:latest-rust-1.61.0 as chef

WORKDIR /app

RUN apt-get update && apt-get install -y lld clang


FROM chef as planner

COPY . .

RUN cargo chef prepare --recipe-path recipe.json


FROM chef as builder

COPY --from=planner /app/recipe.json recipe.json

RUN cargo chef cook --release --recipe-path recipe.json

COPY . .

ENV SQLX_OFFLINE true

RUN cargo build --release


FROM gcr.io/distroless/cc as runtime

WORKDIR /app

COPY --from=builder /app/target/release/app app

ENV APP_ENVIRONMENT production

ENTRYPOINT [ "./app" ]
