# Default target matches `.cargo/config.toml` ([build] target).
target := "thumbv6m-none-eabi"

# Build firmware (release) and emit a raw flash image next to the ELF.
default: bin

bin:
    cargo build --release
    arm-none-eabi-objcopy -O binary target/{{target}}/release/fm-pocket-radio target/{{target}}/release/fm-pocket-radio.bin
    python3 utils/uf2conv.py -c -o target/{{target}}/release/fm-pocket-radio.uf2 target/{{target}}/release/fm-pocket-radio.bin

debug:
    cargo build
    arm-none-eabi-objcopy -O binary target/{{target}}/debug/fm-pocket-radio target/{{target}}/debug/fm-pocket-radio.bin
    python3 utils/uf2conv.py -c -o target/{{target}}/debug/fm-pocket-radio.uf2 target/{{target}}/debug/fm-pocket-radio.bin

clean:
    cargo clean
