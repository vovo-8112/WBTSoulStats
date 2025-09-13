#!/bin/bash

# ============================
# Налаштування
# ============================
BUILD_DIR="build/web"
GH_BRANCH="gh-pages"
MAIN_BRANCH="main"        # <- твоя основна гілка
REPO_URL=$(git config --get remote.origin.url)
BASE_HREF="/wbtsoulstats/"  # <- змінити на свій шлях, якщо потрібно

# ============================
# Збірка Flutter Web
# ============================
echo "💻 Building Flutter Web..."
flutter clean
flutter build web --release --base-href $BASE_HREF

if [ $? -ne 0 ]; then
    echo "❌ Build failed!"
    exit 1
fi

# ============================
# Деплой на gh-pages
# ============================
echo "🌐 Deploying to GitHub Pages..."

# Перевіряємо, чи існує гілка gh-pages локально
if git show-ref --verify --quiet refs/heads/$GH_BRANCH; then
    git checkout $GH_BRANCH
else
    git checkout --orphan $GH_BRANCH
fi

# Копіюємо файли з build/web
rsync -av --delete $BUILD_DIR/ ./

# Додаємо зміни, комітимо, пушимо
git add .
git commit -m "Deploy Flutter Web build $(date +"%Y-%m-%d %H:%M:%S")" --allow-empty
git push origin $GH_BRANCH

# Повертаємось на основну гілку
git checkout $MAIN_BRANCH

echo "✅ Deployment completed!"