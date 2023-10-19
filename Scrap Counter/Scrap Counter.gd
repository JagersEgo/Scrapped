extends Label
@onready var scrap_count = 0

func _process(_delta):
	self.text = str(self.scrap_count)

func _on_button_pressed():
	self.scrap_count += 1
