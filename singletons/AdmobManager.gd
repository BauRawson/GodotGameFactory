extends Node


func _ready() -> void:
	MobileAds.connect("initialization_complete", self, "_on_MobileAds_initialization_complete")
	MobileAds.connect("interstitial_loaded", self, "_on_MobileAds_interstitial_loaded")
	MobileAds.connect("rewarded_interstitial_ad_loaded", self, "_on_MobileAds_rewarded_interstitial_ad_loaded")
	MobileAds.connect("rewarded_ad_loaded", self, "_on_MobileAds_rewarded_ad_loaded")


func _on_MobileAds_initialization_complete(status, adapter_name) -> void:
	if status == MobileAds.INITIALIZATION_STATUS.READY:
		print("We are ready to show ads")
		load_interstitial()
	else:
		print("Ads initialization failed")


func _on_MobileAds_interstitial_loaded() -> void:
	print("Interstitial Loaded")


func _on_MobileAds_rewarded_interstitial_ad_loaded() -> void:
	print("Rewarded Interstitial Ad Loaded")


func _on_MobileAds_rewarded_ad_loaded() -> void:
	print("Rewarded Ad Loaded")


func load_interstitial() -> void:
	MobileAds.load_interstitial()


func load_rewarded_interstitial() -> void:
	MobileAds.load_rewarded_interstitial()


func load_rewarded_video() -> void:
	MobileAds.load_rewarded()


func show_banner() -> void:
	MobileAds.load_banner()


func show_interstitial() -> void:
	MobileAds.show_interstitial()


func show_rewarded_interstitial() -> void:
	MobileAds.show_rewarded_interstitial()


func show_rewarded_video() -> void:
	MobileAds.show_rewarded()
