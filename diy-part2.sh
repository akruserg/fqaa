# 1. Создаем папку (на всякий случай)
mkdir -p target/linux/ramips/image/

# 2. Качаем файл поддержки KN-1121
curl -sSL https://raw.githubusercontent.com/akruserg/fqaa/main/mt76x8.mk > target/linux/ramips/image/keenetic_kn1121.mk

# 3. КРИТИЧЕСКИЙ ШАГ: Прописываем наш файл в главный Makefile
# Мы говорим системе: "Включи содержимое нашего файла в общую сборку"
echo 'include keenetic_kn1121.mk' >> target/linux/ramips/image/Makefile

# 4. Теперь принудительно вписываем выбор устройства в .config
# Это нужно сделать ПОСЛЕ всех скриптов, но ДО make defconfig
echo "CONFIG_TARGET_ramips=y" >> .config
echo "CONFIG_TARGET_ramips_mt76x8=y" >> .config
echo "CONFIG_TARGET_ramips_mt76x8_DEVICE_keenetic_kn-1121=y" >> .config

echo "✅ Поддержка KN-1121 добавлена и активирована."
