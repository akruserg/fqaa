#!/bin/bash

# 1. Создаем папку для DTS (описание железа), если её нет
mkdir -p target/linux/ramips/dts/

# 2. Скачиваем файл описания устройства (DTS)
# ВНИМАНИЕ: Если этот файл не скачается, сборка не увидит KN-1121
curl -sSL https://raw.githubusercontent.com/akruserg/fqaa/main/mt7628an_keenetic_kn-1121.dts > target/linux/ramips/dts/mt7628an_keenetic_kn-1121.dts

# 3. Добавляем инструкции по сборке в основной Makefile прошивок mt76x8
# Мы не заменяем файл, а дописываем в конец
curl -sSL https://raw.githubusercontent.com/akruserg/fqaa/main/mt76x8.mk >> target/linux/ramips/image/mt76x8.mk

# 4. ВАЖНО: Проверяем, как именно называется профиль в скачанном файле, 
# чтобы точно попасть в имя для .config
DEVICE_ID=$(grep "define Device/" target/linux/ramips/image/mt76x8.mk | tail -n 1 | cut -d'/' -f2)
echo "Found Device ID: $DEVICE_ID"

# 5. Принудительно вписываем это устройство в конец .config перед сборкой
echo "CONFIG_TARGET_ramips=y" >> .config
echo "CONFIG_TARGET_ramips_mt76x8=y" >> .config
echo "CONFIG_TARGET_ramips_mt76x8_DEVICE_$DEVICE_ID=y" >> .config
