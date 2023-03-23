shader_type canvas_item;

uniform sampler2D palette : filter_nearest;
uniform int color;

uniform bool is_finished = true;

vec3 average(vec3 input) {
	float mean = (input.x + input.y + input.z) / 3.0;
	return vec3(mean, mean, mean);
}

void fragment() {
	// Place fragment code here.
	vec4 palette_info = texture(TEXTURE, UV);
	if (palette_info.w > 0.0) {
		// Compute color from 0 to 255
		float index = palette_info.x * 255.0;
		
		// Convert to UV index
		vec2 palette_uv = vec2(index / 16.0, (float(color) * 8.0 + 4.0) / 48.0);
		vec4 palette_color = texture(palette, palette_uv);
		
		if (is_finished) {
			vec3 darkened = average(palette_color.xyz) * 0.5;
			palette_color = vec4(darkened, palette_color.w);
		}
		
		COLOR = palette_color;
	} else {
		COLOR = vec4(0, 0, 0, 0);
	}
}
