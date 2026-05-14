shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float blur_strength : hint_range(0.0, 10.0) = 0.0;

void fragment() {

    vec2 size = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 pixel = 1.0 / size;

    vec4 col = vec4(0.0);

    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(-4.0, 0.0) * pixel * blur_strength);
    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(-2.0, 0.0) * pixel * blur_strength);
    col += texture(SCREEN_TEXTURE, SCREEN_UV);
    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(2.0, 0.0) * pixel * blur_strength);
    col += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(4.0, 0.0) * pixel * blur_strength);

    COLOR = col / 5.0;
}