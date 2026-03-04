# 1. Подготовка папок
mkdir -p target/linux/ramips/image/

# 2. Качаем файл
curl -sSL https://raw.githubusercontent.com/akruserg/fqaa/main/mt76x8.mk > target/linux/ramips/image/keenetic_kn1121.mk

# 3. Выясняем реальное имя профиля из скачанного файла
# Ищем строку, которая начинается на 'define Device/'
REAL_DEVICE_NAME=$(grep "define Device/" target/linux/ramips/image/keenetic_kn1121.mk | head -n 1 | cut -d'/' -f2)

echo "🔍 Найден профиль устройства в файле: $REAL_DEVICE_NAME"

# 4. Прописываем в Makefile
echo "include keenetic_kn1121.mk" >> target/linux/ramips/image/Makefile

# 5. Очищаем старые записи и вписываем ПРАВИЛЬНЫЕ
sed -i '/CONFIG_TARGET_ramips_mt76x8_DEVICE/d' .config
echo "CONFIG_TARGET_ramips=y" >> .config
echo "CONFIG_TARGET_ramips_mt76x8=y" >> .config
echo "CONFIG_TARGET_ramips_mt76x8_DEVICE_$REAL_DEVICE_NAME=y" >> .config

echo "✅ Итоговая строка для .config: CONFIG_TARGET_ramips_mt76x8_DEVICE_$REAL_DEVICE_NAME=y"
