extends Control


func _on_save_record_pressed() -> void:
	Database.save_record(123456, "GO HOME!", 50)

func _on_add_employee_pressed() -> void:
	Database.add_employee(100597, "password123", 0)
