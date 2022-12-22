extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
    
    
    pass # Replace with function body.

func _process(delta):
    var origin := get_global_transform().get_origin() / OS.window_size;
    var scale := get_global_transform().get_scale() / 32.0 / OS.window_size;
    
    (material as ShaderMaterial).set_shader_param("offset", origin);
    (material as ShaderMaterial).set_shader_param("scale", scale);
