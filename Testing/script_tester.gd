extends Control


func _on_save_record_pressed() -> void:
	Database.save_record(123456, "GO HOME!", 50)
