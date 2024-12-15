shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}


uniform float onoff= 0.0;
void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	vec4 color = vec4(1.0 - pixelColor.rgb, pixelColor.a);

	if(onoff > 0.5)
	COLOR = color;

	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
