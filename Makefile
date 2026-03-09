reset-pod:
	cd ios && pod deintegrate && rm Podfile.lock && pod repo update && pod install