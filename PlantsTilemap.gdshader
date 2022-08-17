shader_type canvas_item;

uniform sampler2D data_tex;
uniform int num_stages = 8;
uniform vec2 offset;
uniform vec2 scale;
varying vec2 v;

varying vec2 uv_offset;

varying vec4 custom;

void vertex() {
    v = VERTEX;
    float stage = round(texture(data_tex, INSTANCE_CUSTOM.rg).g * float(num_stages));
    uv_offset.y = 0.0;
    uv_offset.x = stage / float(num_stages);

    custom = INSTANCE_CUSTOM;
}

void fragment() {
    vec2 uv = UV;
    uv.x = UV.x / 8.0 + uv_offset.x;
    COLOR = texture(TEXTURE, uv);
}