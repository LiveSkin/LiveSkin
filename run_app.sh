#!/bin/bash

# Скрипт запуска приложения "Живая Кожа"
# Автор: Антон
# Дата: $(date)

echo "🚀 Запуск приложения 'Живая Кожа'..."

# Проверяем, что мы в правильной директории
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Ошибка: pubspec.yaml не найден. Убедитесь, что вы находитесь в корневой папке проекта."
    exit 1
fi

# Проверяем, что Flutter установлен
if ! command -v flutter &> /dev/null; then
    echo "❌ Ошибка: Flutter не установлен. Установите Flutter и попробуйте снова."
    exit 1
fi

echo "📦 Получение зависимостей..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Ошибка при получении зависимостей"
    exit 1
fi

echo "🔍 Проверка доступных устройств..."
flutter devices

echo ""
echo "🎯 Выберите устройство для запуска:"
echo "1) macOS (desktop)"
echo "2) Chrome (web)"
echo "3) iOS Simulator (если доступен)"
echo "4) Android Emulator (если доступен)"
echo ""
read -p "Введите номер устройства (1-4): " device_choice

case $device_choice in
    1)
        echo "🖥️  Запуск на macOS..."
        flutter run -d macos
        ;;
    2)
        echo "🌐 Запуск в Chrome..."
        flutter run -d chrome
        ;;
    3)
        echo "📱 Запуск в iOS Simulator..."
        flutter run -d ios
        ;;
    4)
        echo "🤖 Запуск в Android Emulator..."
        flutter run -d emulator-5554
        ;;
    *)
        echo "❌ Неверный выбор. Запускаю на macOS по умолчанию..."
        flutter run -d macos
        ;;
esac

echo ""
echo "✅ Приложение запущено! Наслаждайтесь изучением 'Живой Кожи'!"
echo ""
echo "📚 Основные функции приложения:"
echo "   • Анатомия - изучите принципы работы нервных окончаний"
echo "   • Гардероб - подберите идеальную одежду"
echo "   • Эксперимент - проведите эксперимент с накачкой мышц"
echo "   • Профиль - отслеживайте свой прогресс"
echo "" 