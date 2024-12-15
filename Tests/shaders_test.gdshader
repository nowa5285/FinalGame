shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform float scale: hint_range(0.0, 1.0, 0.1) = 1.0;
uniform vec4 mod_color : source_color;
uniform sampler2D screen_texture : hint_screen_texture;
uniform sampler2D noise_texture : repeat_enable;

void fragment() {
	//vec2 distortedUV = UV;
	//distortedUV.x += UV.y * 0.2;
	//vec4 pixelColor = texture(TEXTURE, UV * scale);
	//vec4 pixelColor = texture(TEXTURE, UV);
	//float value =(pixelColor.r * pixelColor.g * pixelColor.b)/3.0;
	//COLOR.rgb = pixelColor.ggg;
	//vec4 pixelColor = texture(TEXTURE, UV);
	//COLOR = mix(pixelColor, vec4(1), flash);
	//vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).r * 0.1;
	//vec4 pixelColor = texture(screen_texture, SCREEN_UV);
	//COLOR.rgb = pixelColor.rrr;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
