extends Area2D

signal pop

var increase # speed ratio
var current_color # name of current animation (sprite set) of AnimatedSprite
var random = RandomNumberGenerator.new() # randomizer
# harcoded names of AnimatedSprite's animations
const colors = ['blue', 'green', 'orange', 'pink', 'purple', 'red', 'yellow']

# Get random animation except current one
func get_color():
	var new_color = colors[random.randi_range(0, colors.size() - 1)]
	if new_color == current_color:
		new_color = get_color()
	return new_color

# Hide balloon when its pop sound is finished
func hide_balloon():
	print("Sound finished")
	queue_free()

# Initialize scene
func _init():
	random.randomize()
	current_color = get_color()
	increase = random.randf_range(1, 1.75)

# When node tree has been created and initialized
func _ready():
	# set random sprite set to balloon
	$AnimatedSprite.set_animation(current_color)
	print("New balloon: ", current_color)
	# connect "pop" signal to handler in Playground 
	connect('pop', get_parent(), 'update_score')
	# the "finished" signal of every PopSoundN must hide current balloon
	for i in range(1, 5):
		get_node('PopSound' + str(i)).connect('finished', self, 'hide_balloon')

# On every Timer's interval we move current balloon up
func _on_Timer_timeout():
	position.y -= increase
	# we need to detect how far balloon from upper edge is and destroy it
	# ballon becomes invisible when its first scaled frame height totally above Playground
	var height = $AnimatedSprite.frames.get_frame(current_color, 0).get_size().y * scale.y
	var y = position.y + height
	if y < 0:
		print("Die (out of playground at ", position.y, ")")
		queue_free()

# Detect click/touch event on balloon
func _on_Balloon_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.is_pressed():
			print("Click: ", event.as_text())
			# start pop animation
			$AnimatedSprite.play()
			# play pop sound
			var sound_idx = random.randi_range(1, 5)
			get_node("PopSound" + str(sound_idx)).play()
			print("Sound started: ", sound_idx)
			# emit poop signal so that we can increase score counter in Playground
			emit_signal('pop')
