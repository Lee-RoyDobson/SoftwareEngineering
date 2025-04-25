extends Control


func _on_save_record_pressed() -> void:
	Database.save_record(123456, "GO HOME!", 50)

func _on_add_employee_pressed() -> void:
	Database.add_employee(100597, "password123", 0)

func _on_remove_task_pressed() -> void:
	Database.remove_task(100597, "focus")

func _on_add_manager_pressed() -> void:
	Database.add_manager(999999, "epicPassword")


func _on_get_employees_pressed() -> void:
	print(Database.get_employees())
