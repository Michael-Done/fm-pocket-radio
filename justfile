# Default target matches `.cargo/config.toml` ([build] target).
target := "thumbv6m-none-eabi"

# Build firmware (release) and emit a raw flash image next to the ELF.
default: bin

bin:
    cargo build --release
    arm-none-eabi-objcopy -O binary target/{{target}}/release/fm-radio target/{{target}}/release/fm-radio.bin
    python3 utils/uf2conv.py -c -o target/{{target}}/release/fm-radio.uf2 target/{{target}}/release/fm-radio.bin

debug:
    cargo build
    arm-none-eabi-objcopy -O binary target/{{target}}/debug/fm-radio target/{{target}}/debug/fm-radio.bin
    python3 utils/uf2conv.py -c -o target/{{target}}/debug/fm-radio.uf2 target/{{target}}/debug/fm-radio.bin

clean:
    cargo clean
