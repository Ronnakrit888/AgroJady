extends EquippableItem

class_name HarvestingTool

@export var effected_types : Array[ResourceNodeType]
@export var min_amount : int = 1
@export var max_amount : int = 1

# If the body interacted is a resource node that matches one of the effected types
# set for this tool, then the resource node will be harvested between the minimum and 
# the maximum amount
func interact_with_body(body):
	if body is ResourceNode :
		for type in effected_types:
			if(body.node_types.has(type)):
				#print_debug("Match found at type " + type.display_name + " on " + body.name)
				body.harvest(randi_range(min_amount, max_amount))
	
	if body is Enemy :
		for type in effected_types:
			if body.types.has(type) :
				body.take_damage(randi_range(min_amount, max_amount))
