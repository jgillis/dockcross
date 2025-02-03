#!/usr/bin/env bash

set -ex
set -o pipefail

if [[ "$AUDITWHEEL_ARCH" == "i686" ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://static.rust-lang.org/rustup/dist/i686-unknown-linux-gnu/rustup-init > rustup-init
	chmod +x rustup-init
	RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/rust ./rustup-init -y --default-host=i686-unknown-linux-gnu --default-toolchain=1.84.1 --no-modify-path
else
	curl --proto '=https' --tlsv1.2 -sSf https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init > rustup-init
	chmod +x rustup-init
	RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/rust ./rustup-init -y --default-toolchain=1.84.1 --no-modify-path
fi

RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/rust /opt/rust/bin/cargo install cbindgen --version 0.28.0

for FILE in /opt/rust/bin/*; do
    if [[ -x "$FILE" && -f "$FILE" ]]; then
        FILENAME="${FILE##*/}"  # Extract just the filename
        echo -e "#!/bin/sh\nRUSTUP_HOME=/opt/rust exec /opt/rust/bin/\${0##*/} \"\$@\"" > /usr/local/bin/$FILENAME
        chmod +x /usr/local/bin/$FILENAME
    fi
done
