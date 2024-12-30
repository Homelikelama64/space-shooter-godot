shader_type canvas_item;

uniform vec2 position = vec2(0.0,0.0);
uniform float scale = 100.0;
uniform float cutoff: hint_range(0.5, 1.0, 0.001) = 0.98;
uniform float gamma: hint_range(-1.0, 1.0, 0.01) = 0.0;

float random(inout uint state){
    state = state * 747796405u + 2891336453u;
	uint result = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
	result = (result >> 22u) ^ result;
    return float(result) / 4294967295.0;
}

void fragment() {
	vec2 unrounded = vec2(UV.x * scale + position.x / 2.0 + 100000.0,UV.y * scale + position.y / 2.0 + 10000.0);
	vec2 pos = vec2(round(unrounded.x),round(unrounded.y));
	uint state = uint(pos.x * pos.y);
	float value = random(state);
	vec4 output = vec4(0.05,0.05,0.05,1.0);
	if (value > cutoff) {
		float brightness = (value - cutoff) / (1.0 - cutoff) + gamma;
		output = vec4(brightness,brightness,brightness,1.0);
	}
	COLOR = output;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}