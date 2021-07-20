extends Node

"""
This SoundManager class is based on tutorials created by John Ivess
link: https://www.youtube.com/watch?v=AsVc0zGp7Uc

How it works:
	First we load all the sounds placed inside res://assets/sounds/ and
	place them inside the sounds_dictionary, using the sound name as the 
	dictionary key.
	
	Then, from anywhere in the game, we can call play_sound(sound_name) and it
	will play :)
"""


var sound_folder_path: String = "res://assets/sounds"
var sounds_dictionary: Dictionary = {}

var supported_audio_files: Array = [".wav", ".ogg", ".mp3"]


func _ready() -> void:
	load_sound_paths_dictionary(sound_folder_path)


func play_sound(sound_name: String, parent: Object) -> void:
	if !sounds_dictionary.has(sound_name):
		print("Sound not present in sounds dictionary: " + sound_name)
		return
	
	var sound_stream: AudioStream = sounds_dictionary[sound_name]
	
	if sound_stream and parent:
		var stream_player: AudioStreamPlayer = AudioStreamPlayer.new()		
		stream_player.stream = sound_stream
		
		stream_player.connect("finished", self, "queue_free")
		
		parent.add_child(stream_player)
		stream_player.play()


func load_sound_paths_dictionary(_sound_folder_path: String) -> void:
	var directory: Directory = Directory.new()
	if directory.open(_sound_folder_path) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		
		while file_name != "":
			if directory.current_is_dir():
				pass # If you want recursive file loading, do it here. I think
			else:    # it's a bit overkill :)
				for file_type in supported_audio_files:
					if file_name.ends_with(file_type):
						var sound_file_path: String = sound_folder_path + "/" + file_name
						var new_audio_stream = load(sound_file_path)
						if new_audio_stream is AudioStream:
							sounds_dictionary[file_name.trim_suffix(file_type)] = new_audio_stream
						print("Successfully loaded sound: " + sound_file_path)
			
			file_name = directory.get_next()
	else:
		print("An error occurred when trying to access the sounds path: " + sound_folder_path)

