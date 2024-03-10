@tool
extends Sprite2D

class_name HandEquip

signal noEquipItem
signal haveEquipItem

@export var equipped_item : EquippableItem : 
	set(next_equipped):
		equipped_item = next_equipped
		
		if next_equipped != null :
			self.texture = equipped_item.texture
			haveEquipItem.emit()
		else :
			self.texture = null
			noEquipItem.emit()

func _on_area_2d_body_entered(body):
	if equipped_item.has_method("interact_with_body"):
		equipped_item.interact_with_body(body)
		
	for child in body.get_children() :
		if child is Damageable :
			child.hit(equipped_item.damage)
