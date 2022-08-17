shader_type canvas_item;

uniform vec2 pixel_size;
uniform float delta = 0.0;

uniform float spontanous_spawn_chance = 0.0001;
uniform float reproduction_chance = 0.1;
uniform vec4 new_plant_color : hint_color = vec4(0.0, 0.05, 0.0, 1.0);
uniform float plant_grow_rate = 0.01;
uniform float plant_decay_rate = 0.01;
uniform float shadow_factor = 2.0;

float choas_func(in float seed) {
    // Idea from: https://humphryscomputing.com/Notes/Neural/chaos.html
    return (1.0 + sin(1.0 / mod(seed, 0.001))) / 2.0;
}

void fragment() {
    vec4 self = texture(TEXTURE, UV);
    COLOR = self;

    if(delta > 0.0) {
        vec4 neighbors = vec4(0.0);
        float sum_weights = 0.0;
        for(int y = -2; y <= 2; y++) {
            for(int x = -2; x <= 2; x++) {
                if((x != 0) || (y != 0)) {
                    vec2 diff = vec2(float(x), float(y));
                    float weight = 1.0 / length(diff);
                    vec2 uv = UV + diff * pixel_size;
                    neighbors += texture(TEXTURE, uv) * weight;
                    sum_weights += weight;
                }
            }
        }
        neighbors /= sum_weights;
        
        float rnd = choas_func(TIME * UV.x * UV.y);
        if(COLOR.g > 0.0) {
            // process plant
            COLOR.g += max(-plant_decay_rate, (1.0 - neighbors.g * shadow_factor) * plant_grow_rate) * delta * rnd;
        }
        else if (COLOR.r > 0.0) {
            // process animal
        }
        else{
            if(rnd < reproduction_chance * neighbors.g) {
                COLOR = new_plant_color;
            }
            else if(rnd < spontanous_spawn_chance) {
                COLOR = new_plant_color;
            }
        }
    }
}