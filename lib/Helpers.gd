extends Node
class_name Helpers
static func reparent_node(child, source, destination):
	source.remove_child(child)
	destination.add_child(child)
	child.set_owner(destination)
static func debug_print(text):
	if OS.is_debug_build():
		print(text)