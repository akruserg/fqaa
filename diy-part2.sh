# 1. Проверяем, где мы находимся (для логов)
echo "Current directory: $(pwd)"

# 2. Путь, куда ДОЛЖЕН попасть файл (относительно корня openwrt)
TARGET_PATH="target/linux/ramips/image"

# 3. Создаем дерево папок, если его нет (флаг -p не выдаст ошибку, если папка есть)
mkdir -p "$TARGET_PATH"

# 4. Качаем файл именно туда
echo "Downloading mt76x8.mk to $TARGET_PATH..."
curl -sSL https://raw.githubusercontent.com/akruserg/fqaa/main/mt76x8.mk > "$TARGET_PATH/mt76x8.mk"

# 5. Проверка: скачался ли файл?
if [ -f "$TARGET_PATH/mt76x8.mk" ]; then
    echo "✅ Файл успешно размещен в $TARGET_PATH"
else
    echo "❌ ОШИБКА: Не удалось создать файл в $TARGET_PATH"
    exit 1
fi
