run:
	cargo run -q

lint:
	cargo clippy

format:
	cargo fmt

coverage:
	cargo tarpaulin --ignore-tests
