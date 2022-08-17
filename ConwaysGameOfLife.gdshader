shader_type canvas_item;

uniform vec2 pixel_size;
uniform bool process = false;

uniform vec4 color_born : hint_color = vec4(0.5, 8.0, 0.5, 1.0);
uniform vec4 color_survive : hint_color = vec4(0.9, 0.9, 0.9, 1.0);
uniform vec4 color_dead : hint_color = vec4(0.2, 0.0, 0.0, 1.0);

bool is_alive(in vec4 fragment) {
    return fragment.r > 0.5;
}    

void fragment() {
    vec2 my_uv = UV ;
    vec4 self = textureLod(TEXTURE, my_uv, 0.0);
    COLOR = vec4(self);
    
    if(process) {
        int num_neighbors = 0;
        for(int y = -1; y <= 1; y++) {
            for(int x = -1; x <= 1; x++) {
                if((x != 0) || (y != 0)) {
                    vec2 uv = my_uv + vec2(float(x), float(y)) * pixel_size;
                    if( is_alive(textureLod(TEXTURE, uv, 0.0)) ) {
                        num_neighbors++;
                    }
                }
            }
        }
        
        if( is_alive(self)) {
            if(num_neighbors > 3) {
                COLOR = color_dead;
            }
            else if(num_neighbors < 2) {
                COLOR = color_dead;
            }
            else {
                COLOR = color_survive;
            }
        }
        else {
            if(num_neighbors == 3) {
                COLOR = color_born;
            }
            else {
                COLOR = vec4(0.0,0.0,0.0,1.0); // <- BLACK
            }
        }
    }
}