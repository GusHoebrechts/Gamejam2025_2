extends Node2D

var first = true

func _on_interactwithchestsphere_body_entered(body: Node2D) -> void:
		if(body.is_in_group("Player") and first):
			body.add_score(1000)
			self.hide()
			first = false
