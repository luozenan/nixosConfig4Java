#!/bin/bash

USER_HOME="/home/luozenan"
LOCALE_DIR="$USER_HOME/.locale"

# 找 deepin-base layer
BASE_LAYER=$(grep -rl '"id": "org.deepin.base"' /var/lib/linglong/layers/*/info.json \
  2>/dev/null | head -1 | xargs -r dirname 2>/dev/null)

# 找 deepin-foundation layer（包含 /usr/lib/locale）
FOUNDATION_LAYER=$(grep -rl '"id": "org.deepin.base.wine"' /var/lib/linglong/layers/*/info.json \
  2>/dev/null | head -1 | xargs -r dirname 2>/dev/null)

if [ -z "$BASE_LAYER" ] || [ -z "$FOUNDATION_LAYER" ]; then
  echo "deepin-wine-locale: layers not found, skipping."
  exit 0
fi

LOCALE_TARGET="$FOUNDATION_LAYER/files/usr/lib/locale"

if [ -d "$LOCALE_TARGET/zh_CN.UTF-8" ]; then
  echo "deepin-wine-locale: already exists, skipping."
  exit 0
fi

echo "deepin-wine-locale: generating zh_CN.UTF-8..."
TMPDIR=$(mktemp -d)
LOCALE_TMP=$(mktemp -d)
trap "rm -rf $TMPDIR $LOCALE_TMP" EXIT

for f in zh_CN iso14651_t1_common iso14651_t1 iso14651_t1_pinyin i18n POSIX; do
  cp "$BASE_LAYER/files/usr/share/i18n/locales/$f" "$TMPDIR/"
done
cp "$BASE_LAYER/files/usr/share/i18n/locales/translit_"* "$TMPDIR/" 2>/dev/null || true

cp "$BASE_LAYER/files/usr/share/i18n/charmaps/UTF-8.gz" "$TMPDIR/"
@gzip@/bin/gunzip -f "$TMPDIR/UTF-8.gz"

mkdir -p "$LOCALE_TMP"
I18NPATH="$TMPDIR" "$BASE_LAYER/files/usr/bin/localedef" --no-archive \
  -i "$TMPDIR/zh_CN" \
  -f "$TMPDIR/UTF-8" \
  "$LOCALE_TMP/zh_CN.UTF-8"

mkdir -p "$LOCALE_TARGET"
rm -rf "$LOCALE_TARGET/zh_CN.UTF-8" "$LOCALE_TARGET/zh_CN.utf8"
cp -r "$LOCALE_TMP/zh_CN.UTF-8" "$LOCALE_TARGET/"
ln -sf "$LOCALE_TARGET/zh_CN.UTF-8" "$LOCALE_TARGET/zh_CN.utf8"

echo "deepin-wine-locale: done."
