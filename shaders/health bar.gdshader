shader_type canvas_item;


uniform float health:hint_range(0.0, 1.0, 0.1) = 0.5;
uniform vec4 health_color = vec4(0.5,1,0.5,1);
uniform vec4 dead_color = vec4(1,0.5,0.5,1);
uniform sampler2D mask: filter_nearest;
uniform float start = 1.0;
uniform float end = 1.0;

void fragment() {
	float start_uv = start * TEXTURE_PIXEL_SIZE.x;
	float end_uv = 1.0 - end * TEXTURE_PIXEL_SIZE.x;
	vec4 color = texture(TEXTURE,UV);
	vec4 mask_color = texture(mask,UV);
	if (mask_color.a > 0.5) {
		float percent = start_uv + (end_uv - start_uv) * health;
		if (percent > UV.x) {
			color = health_color;
		}
		if (percent < UV.x) {
			color = dead_color;
		}
	}
	
	COLOR = color;
}
