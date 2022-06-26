run:
	mold -run cargo run -q

check:
	mold -run cargo check

miri:
	mold -run cargo +nightly miri run

test:
	mold -run cargo nextest run -j 16

lint:
	mold -run cargo clippy
