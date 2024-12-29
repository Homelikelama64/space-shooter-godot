shader_type canvas_item;

uniform vec2 dir = vec2(1.0,0.0);
uniform vec4 shadow_color = vec4(1.0,1.0,1.0,1.0);
uniform float len = 1.0;
uniform float cutoff:hint_range(0, 1, 0.001) = 0.5;


void fragment() {
	vec4 color = texture(TEXTURE,UV);
	if (color.a < 0.2) {
		float current_len = len;
		while (current_len > -1.0) {
			vec2 new_uv = UV - dir * TEXTURE_PIXEL_SIZE * (len - current_len);
			vec4 other_color = texture(TEXTURE,new_uv);
			vec4 dif = other_color - color;
			current_len -= 1.0;
			if (other_color.a > cutoff) {
				color = other_color * shadow_color;
				break;
			}
			
		}
	}
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
