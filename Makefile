reset-pod:
	cd ios && pod deintegrate && rm Podfile.lock && pod repo update && pod install

# ── Qualité ────────────────────────────────────────────────────────────────────
coverage:
	./scripts/coverage.sh

sonar:
	sonar-scanner

ci-quality: coverage sonar