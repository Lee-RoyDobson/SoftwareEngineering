class_name database extends Node

func save_record(employee: int, feedback: String, score: int) -> bool:
	return true

func retrieve_difficulty(employee: int) -> int:
	return 0

func retrieve_feedback(employee: int) -> String:
	return "Good!"

func add_employee(employee: int) -> bool:
	return true

func remove_employee(employee: int) -> bool:
	return true

func add_manager(manager: int) -> bool:
	return true

func remove_manager(manager: int) -> bool:
	return true

func get_employee(employee: int) -> Array:
	return []

func get_tasks(employee: int) -> Array:
	return []

func get_scores(employee: int) -> int:
	return 0

func add_task(employee: int, task: int) -> bool:
	return true

func remove_task(employee: int, task: int) -> bool:
	return true

func save_score(employee: int, task: int, score: int) -> bool:
	return true
