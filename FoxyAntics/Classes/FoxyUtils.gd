class_name FoxyUtils


static func formatted_dt() -> String:
	var dt = Time.get_datetime_dict_from_system()
	return "%02d:%02d %02d/%02d/%02d" % [
		dt.hour, dt.minute, dt.month, dt.day, dt.year
	]
