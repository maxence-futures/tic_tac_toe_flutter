#!/usr/bin/env bash
# Génère un rapport de couverture LCOV nettoyé (sans les fichiers générés).
# Usage : ./scripts/coverage.sh
# Prérequis : lcov  → brew install lcov

set -euo pipefail

echo "▶ flutter test --coverage"
flutter test --coverage

echo "▶ Nettoyage du rapport LCOV (exclusion des fichiers générés)"
lcov --remove coverage/lcov.info \
  '**/*.g.dart' \
  '**/*.freezed.dart' \
  '**/*.gr.dart' \
  '*/lib/l10n/*' \
  --output-file coverage/lcov.info \
  --ignore-errors unused

echo "✅ Rapport disponible : coverage/lcov.info"

# Optionnel — ouvrir le rapport HTML dans le navigateur
if command -v genhtml &>/dev/null; then
  genhtml coverage/lcov.info --output-directory coverage/html
  open coverage/html/index.html
fi
