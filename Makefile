run:
	mold -run cargo run

check:
	mold -run cargo check

miri:
	mold -run cargo +nightly miri run

test:
	mold -run cargo nextest run

lint:
	mold -run cargo clippy
