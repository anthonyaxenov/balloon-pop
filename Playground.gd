extends Node2D

var score = -1 # pop counter; will be set to 0 in "_ready()"
var screen_size # screen size lol
var current_music # index 1..7 of AudioStreamPlayer ("MusicN") nodes
var random = RandomNumberGenerator.new() # randomizer
var balloon_scene = load("res://Balloon.tscn") # scene with balloon
var offset_y = 280 # top coordinate under bottom edge of playground to spawn balloons

# Get random music index except current one
func get_music_idx():
	var new_current_music = random.randi_range(1, 7)
	# if random equals to current -- regenerate
	if new_current_music == current_music:
		new_current_music == get_music_idx()
	return new_current_music

# Play next random music
func play_music():
	current_music = get_music_idx()
	get_node('Music' + str(current_music)).play()
	print("Music started: ", current_music)

# Initialize scene
func _init():
	random.randomize()

# When node tree has been created and initialized
func _ready():
	screen_size = get_viewport_rect().size # needed to seed balloons
	update_score() # set 0 in global pop counter
	play_music() # play random music
	$TextureRect.set_position(Vector2(0, 0))
	$TextureRect.rect_size.x = screen_size.x
	$TextureRect.rect_size.y = screen_size.y
	# the "finished" signal of every MusicN must start another music
	for i in range(1, 7):
		get_node('Music' + str(i)).connect('finished', self, 'play_music')

# On every Timer's interval we add new ballon under
# the bottom edge of the playground (screen) and
# randomly flip it horizontally 
func _on_Timer_timeout():
	# create new balloon virtually
	var balloon = balloon_scene.instance()
	# calculate new horizontal position
	var x = rand_range(10, screen_size.x - 10)
	# calculate balloon's scaled height
	# set new position to balloon under the playground (screen)
	balloon.set_position(Vector2(x, screen_size.y + offset_y))
	# randomly flip balloon horizontally
	# '0' child is AnimatedSprite of Balloon scene 
	balloon.get_child(0).flip_h = bool(random.randi_range(0, 1))
	balloon.z_index = 10 # place balloon over other objects
	add_child(balloon) # place balloon on playground

# Receive "pop" signal from Balloon scene to increment global score counter
func update_score():
	score += 1 # increment
	$Label.text = str(score) # show
