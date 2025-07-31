#!/bin/bash

# HolySpots IPA Build Script
# Скрипт для сборки IPA файла Flutter iOS приложения

echo "🚀 Начинаем сборку IPA для HolySpots..."

# Проверяем, что мы в правильной директории
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Ошибка: pubspec.yaml не найден. Убедитесь, что вы находитесь в корневой папке Flutter проекта."
    exit 1
fi

# Проверяем, что Xcode установлен
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Ошибка: Xcode не найден. Установите Xcode для сборки iOS приложений."
    exit 1
fi

# Очищаем предыдущие сборки
echo "🧹 Очищаем предыдущие сборки..."
flutter clean

# Получаем зависимости
echo "📦 Получаем зависимости..."
flutter pub get

# Проверяем Flutter
echo "🔍 Проверяем Flutter..."
flutter doctor

# Переходим в iOS директорию
cd ios

# Очищаем iOS проект
echo "🧹 Очищаем iOS проект..."
xcodebuild clean -workspace Runner.xcworkspace -scheme Runner

# Возвращаемся в корневую директорию
cd ..

# Собираем iOS приложение
echo "🔨 Собираем iOS приложение..."
flutter build ios --release --no-codesign

# Проверяем, что сборка прошла успешно
if [ $? -eq 0 ]; then
    echo "✅ iOS приложение успешно собрано!"
    echo "📱 Приложение находится в: build/ios/iphoneos/Runner.app"
    
    # Создаем IPA файл (требует подписанный код)
    echo "📦 Создаем IPA файл..."
    
    # Проверяем наличие подписанного приложения
    if [ -d "build/ios/iphoneos/Runner.app" ]; then
        echo "📏 Размер приложения: $(du -sh build/ios/iphoneos/Runner.app | cut -f1)"
        echo "ℹ️  Для создания IPA файла требуется подписанный код."
        echo "💡 Используйте Xcode для подписи и создания IPA:"
        echo "   1. Откройте ios/Runner.xcworkspace в Xcode"
        echo "   2. Выберите Product -> Archive"
        echo "   3. В Organizer выберите Distribute App"
        echo "   4. Выберите Ad Hoc или App Store"
        echo "   5. Подпишите и экспортируйте IPA"
    else
        echo "❌ Приложение не найдено в build/ios/iphoneos/Runner.app"
    fi
    
    echo "🎉 Сборка завершена успешно!"
else
    echo "❌ Ошибка при сборке iOS приложения"
    exit 1
fi 