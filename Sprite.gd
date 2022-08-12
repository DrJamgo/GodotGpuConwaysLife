extends Sprite

var process = false

func _ready():
    var tex_size := texture.get_size()
    var pixel_size =  Vector2(1.0 / tex_size.x, 1.0 / tex_size.y)
    (material as ShaderMaterial).set_shader_param("pixel_size", pixel_size) 

func _input(event):
    var mouse = event as InputEventMouseMotion
    if mouse:
        $Cursor.rect_position = mouse.position - Vector2(0.5,0.5)
        
func _process(delta):
    # This 'draws' a new pixel to the texture
    $Cursor.visible = Input.is_mouse_button_pressed(BUTTON_LEFT)

func _simulation_step():
    (material as ShaderMaterial).set_shader_param("process", true)
    yield(get_tree(), "idle_frame")
    (material as ShaderMaterial).set_shader_param("process", false)

func _on_Timer_timeout():
    _simulation_step()

func _on_simulation_speed_changed(value):
    $Timer.wait_time = 1.0 / value

func _on_simulation_enabled(button_pressed):
    if button_pressed:
        $Timer.start()
    else:
        $Timer.stop()

func _on_Button_pressed():
    yield(get_tree(), "idle_frame")
    _simulation_step()
    
