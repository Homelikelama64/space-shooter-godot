shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE:hint_screen_texture;
uniform vec4 tint = vec4(1.0);
void fragment() {
	vec4 total = 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x,-SCREEN_PIXEL_SIZE.y)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(0.0,-SCREEN_PIXEL_SIZE.y)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x,-SCREEN_PIXEL_SIZE.y)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x,0.0)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(0.0,0.0)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x,0.0)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(-SCREEN_PIXEL_SIZE.x,SCREEN_PIXEL_SIZE.y)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(0.0,SCREEN_PIXEL_SIZE.y)) + 
	texture(SCREEN_TEXTURE,SCREEN_UV + vec2(SCREEN_PIXEL_SIZE.x,SCREEN_PIXEL_SIZE.y));
	COLOR = (total / 9.0) * tint;
}

