extends Node


var payment


func _ready() -> void:
	if Engine.has_singleton("GodotGooglePlayBilling"):
		payment = Engine.get_singleton("GodotGooglePlayBilling")
		# These are all signals supported by the API
		# You can drop some of these based on your needs
		payment.connect("connected", self, "_on_connected") # No params
		payment.connect("disconnected", self, "_on_disconnected") # No params
		payment.connect("connect_error", self, "_on_connect_error") # Response ID (int), Debug message (string)
		payment.connect("purchases_updated", self, "_on_purchases_updated") # Purchases (Dictionary[])
		payment.connect("purchase_error", self, "_on_purchase_error") # Response ID (int), Debug message (string)
		payment.connect("sku_details_query_completed", self, "_on_sku_details_query_completed") # SKUs (Dictionary[])
		payment.connect("sku_details_query_error", self, "_on_sku_details_query_error") # Response ID (int), Debug message (string), Queried SKUs (string[])
		payment.connect("purchase_acknowledged", self, "_on_purchase_acknowledged") # Purchase token (string)
		payment.connect("purchase_acknowledgement_error", self, "_on_purchase_acknowledgement_error") # Response ID (int), Debug message (string), Purchase token (string)
		payment.connect("purchase_consumed", self, "_on_purchase_consumed") # Purchase token (string)
		payment.connect("purchase_consumption_error", self, "_on_purchase_consumption_error") # Response ID (int), Debug message (string), Purchase token (string)

		payment.startConnection()
	else:
		print("Android IAP support is not enabled. Make sure you have enabled 'Custom Build' and the GodotGooglePlayBilling plugin in your Android export settings! IAP will not work.")


func _on_connected() -> void:
	print("Billing successfully connected -- we should query sku details here")


func _on_disconnected() -> void:
	print("Billing disconnected")


func _on_connect_error(response_id: int, message: String) -> void:
	print("Connect error: " + message)


func _on_purchases_updated(purchases: Dictionary) -> void:
	print("Purchases updated -- we should acknowledge purchases here")
	print(purchases)


func _on_purchase_error(response_id: int, message: String) -> void:
	print("Purchase error: " + message)


func _on_sku_details_query_completed(skus: Dictionary) -> void:
	print("SKU details query completed")
	print(skus)


func _on_sku_details_query_error(response_id: int, message: String, queried_skus: Array) -> void:
	print("SKU details query error: " + message)


func _on_purchase_acknowledged(purchase_token: String) -> void:
	print("Purchase acknowledged: " + purchase_token)


func _on_purchase_acknowledgement_error(response_id: int, message: String, purchase_token: String) -> void:
	print("Purchase acknowledgement error: " + message)


func _on_purchase_consumed(purchase_token: String) -> void:
	print("Purchase consumed: " + purchase_token)


func _on_purchase_consumption_error(response_id: int, message: String, purchase_token: String) -> void:
	print("Purchase consumption error: " + message)
