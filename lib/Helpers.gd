extends Node
class_name Helpers
static func reparent_node(child, source, destination):
	source.remove_child(child)
	destination.add_child(child)
	child.set_owner(destination)