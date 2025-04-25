class_name database extends Node

func save_record(employee: int, feedback: String, score: int) -> bool:
	
	var date = Time.get_date_string_from_system()
	
	var path = "res://Data/Employees/" + str(employee) + "/" + date
	var data_entry = FileAccess.open(path, FileAccess.WRITE)
	if data_entry:
		print("Data entry found")
		var data = {
			"score": score,
			"feedback": feedback
		}
		data_entry.store_line(JSON.stringify(data))
		
		var current_data = FileAccess.open("res://Data/Employees/" + str(employee) + "/" + "Current", FileAccess.WRITE)
		current_data.store_line(JSON.stringify(data))
		return true
	else:
		print("Data entry not found at " + path)
		return false

func retrieve_feedback(employee: int) -> String:
	return "Good!"

func add_employee(employee: int, password: String) -> bool:
	var path = "res://Data/Employees/" + str(employee) + "/LoginDetails"
	
	var directory = DirAccess.open("res://Data/Employees/")
	
	if directory.dir_exists("res://Data/Employees/" + str(employee)):
		print("User already exists")
		return false
	
	if directory:
		print("Directory res://Data/Employees/ opened.")
		directory.make_dir(str(employee))
	else:
		print("Directory res://Data/Employees/ failed to open.")
		return false
	
	var data_entry = FileAccess.open(path, FileAccess.WRITE)
	if data_entry:
		print("User added at: " + path)
		var data = {
			"username": employee,
			"password": password,
			"access": 0
		}
		
		data_entry.store_line(JSON.stringify(data))
		
		var tasks_data = FileAccess.open("res://Data/Employees/" + str(employee) + "/Tasks", FileAccess.WRITE)
		
		data = {
			"memory": false,
			"reaction": false,
			"focus": false
		}
		tasks_data.store_line(JSON.stringify(data))
		
		var current_data = FileAccess.open("res://Data/Employees/" + str(employee) + "/Current", FileAccess.WRITE)
		data = {
			"score": 0,
			"feedback": "No feedback yet"
		}
		
		current_data.store_line(JSON.stringify(data))
		return true
	else:
		print("User failed to create at: " + path)
		print(FileAccess.get_open_error())
		return false

func remove_employee(employee: int) -> bool:
	var directory = DirAccess.open("res://Data/Employees/" + str(employee))
	if not directory:
		print("res://Data/Employees/" + str(employee)+ " not found")
		return false
	
	OS.move_to_trash(ProjectSettings.globalize_path("res://Data/Employees/" + str(employee)))
	return true

func add_manager(manager: int, password: String) -> bool:
	var path = "res://Data/Managers/" + str(manager) + "/LoginDetails"
	
	var directory = DirAccess.open("res://Data/Managers/")
	
	if directory.dir_exists("res://Data/Managers/" + str(manager)):
		print("User already exists")
		return false
	
	if directory:
		print("Directory res://Data/Managers/ opened.")
		directory.make_dir(str(manager))
	else:
		print("Directory res://Data/Managers/ failed to open.")
	
	var data_entry = FileAccess.open(path, FileAccess.WRITE)
	if data_entry:
		print("User added at: " + path)
		var data = {
			"username": manager,
			"password": password,
			"access": 1
		}
		
		data_entry.store_line(JSON.stringify(data))
		
		return true
	else:
		print("User failed to create at: " + path)
		print(FileAccess.get_open_error())
		return false

func remove_manager(manager: int) -> bool:
	var directory = DirAccess.open("res://Data/Managers/" + str(manager))
	if not directory:
		print("res://Data/Managers/" +str(manager)+ " not found")
		return false
	
	OS.move_to_trash(ProjectSettings.globalize_path("res://Data/Managers/" + str(manager)))
	return true

func get_employee(employee_id: int, password: String) -> Array:
	var logged_in: bool = false
	var access_level: int = 0
	var employee_dir = DirAccess.open("res://Data/Employees/")
	for employee in employee_dir.get_directories():
		if employee == str(employee_id):
			var login_data = FileAccess.open("res://Data/Employees/" + employee + "/LoginDetails", FileAccess.READ)
			var json = JSON.new()
			json.parse(login_data.get_line())
			
			var password_data = json.data
			
			if password_data["password"] == password:
				logged_in = true
	
	if not logged_in:
		var manager_dir = DirAccess.open("res://Data/Managers/")
		for manager in manager_dir.get_directories():
			if manager == str(employee_id):
				var login_data = FileAccess.open("res://Data/Managers/" + manager + "/LoginDetails", FileAccess.READ)
				var json = JSON.new()
				json.parse(login_data.get_line())
				
				var password_data = json.data
				
				if password_data["password"] == password:
					logged_in = true
					access_level = 1
	
	if not logged_in:
		var admin_dir = DirAccess.open("res://Data/Admins/")
		for admin in admin_dir.get_directories():
			if admin == str(employee_id):
				var login_data = FileAccess.open("res://Data/Admins/" + admin + "/LoginDetails", FileAccess.READ)
				var json = JSON.new()
				json.parse(login_data.get_line())
				
				var password_data = json.data
				
				if password_data["password"] == password:
					logged_in = true
					access_level = 2
	
	return [logged_in, access_level]

func get_employees() -> Array:
	var employee_data = []
	var directory = DirAccess.open("res://Data/Employees/")
	for employee: String in directory.get_directories():
		var tasks_completed = true
		
		var data_entry = FileAccess.open("res://Data/Employees/" + employee + "/Tasks", FileAccess.READ)
		var json = JSON.new()
		json.parse(data_entry.get_line())
		
		var tasks = json.data
		
		# Check tasks for any not completed
		for task in tasks:
			if not tasks[task]:
				tasks_completed = false
		
		data_entry = FileAccess.open("res://Data/Employees/" + employee + "/Current", FileAccess.READ)
		json.parse(data_entry.get_line())
		
		var score = json.data["score"]
		
		employee_data.append({
			"username": employee,
			"score": score,
			"completed": tasks_completed
		})
	return employee_data

func get_tasks(employee: int) -> Dictionary:
	var data_entry = FileAccess.open("res://Data/Employees/" + str(employee) + "/Tasks", FileAccess.READ)
	var json = JSON.new()
	json.parse(data_entry.get_line())
	
	var tasks = json.data
	return tasks

func get_score(employee: int) -> int:
	var data_entry = FileAccess.open("res://Data/Employees/" + str(employee) + "/Current", FileAccess.READ)
	var json = JSON.new()
	json.parse(data_entry.get_line())
		
	var score = json.data["score"]
	return score

func add_task(employee: int, task: String) -> bool:
	var path = "res://Data/Employees/" + str(employee) + "/Tasks"
	var data_entry = FileAccess.open(path, FileAccess.READ)
	
	var json = JSON.new()
	
	json.parse(data_entry.get_line())
	var data = json.data
	
	print(data)
	data[task] = false
	
	print(data)
	
	data_entry = FileAccess.open(path, FileAccess.WRITE)
	data_entry.store_line(JSON.stringify(data))
	
	return true

func remove_task(employee: int, task: String) -> bool:
	var path = "res://Data/Employees/" + str(employee) + "/Tasks"
	var data_entry = FileAccess.open(path, FileAccess.READ)
	
	var json = JSON.new()
	
	json.parse(data_entry.get_line())
	var data = json.data
	
	print(data)
	data[task] = true
	
	print(data)
	
	data_entry = FileAccess.open(path, FileAccess.WRITE)
	data_entry.store_line(JSON.stringify(data))
	
	return true

func save_score(employee: int, task: int, score: int) -> bool:
	return true

func add_admin(admin: int, password: String) -> bool:
	var path = "res://Data/Admins/" + str(admin) + "/LoginDetails"
	
	var directory = DirAccess.open("res://Data/Admins/")
	
	if directory.dir_exists("res://Data/Admins/" + str(admin)):
		print("User already exists")
		return false
	
	if directory:
		print("Directory res://Data/Admins/ opened.")
		directory.make_dir(str(admin))
	else:
		print("Directory res://Data/Admins/ failed to open.")
	
	var data_entry = FileAccess.open(path, FileAccess.WRITE)
	if data_entry:
		print("User added at: " + path)
		var data = {
			"username": admin,
			"password": password,
			"access": 2
		}
		
		data_entry.store_line(JSON.stringify(data))
		
		return true
	else:
		print("User failed to create at: " + path)
		print(FileAccess.get_open_error())
		return false
	
func remove_admin(admin: int) -> bool:
	var directory = DirAccess.open("res://Data/Admins/" + str(admin))
	if not directory:
		print("res://Data/Admins/"+ str(admin) + " not found")
		return false
	
	OS.move_to_trash(ProjectSettings.globalize_path("res://Data/Admins/" + str(admin)))
	return true
