/**
 *
 *
 */

shader_type canvas_item;
render_mode blend_mix,unshaded;

// PascalCase names are setup uniforms
// snake_case names are private scope

// Holds the mask for the flask/bar/etc
uniform sampler2D ContainerMask : hint_albedo;
// Holds the mask for the liquid animation
uniform sampler2D ContentMask : hint_albedo;
// Configures the active area of the image used as progress bar
// since the bar mey not go from bottom to top
uniform float ActiveArea = 0.9;
// Configures offset in case the bar does not start on the very bottom
uniform float BarOffset = 0.02;
// Content mask compression in X axis
uniform float UV_X_Scale = 1.0;
// Main control variable for liquid level
uniform float Progress = 0.0;

void fragment()  {
	// Calculates UV with offset for progress
	vec2 uv_content = UV;
	uv_content.x = fract(uv_content.x * UV_X_Scale);
	uv_content.y -= (1.0 - clamp(Progress*ActiveArea, 0.0, 1.0)) - BarOffset;
	
	// Extract pixels from base texture and masks
	vec4 base_tex = texture(TEXTURE, UV);
	vec4 container_tex = texture(ContainerMask, UV);
	vec4 content_tex = texture(ContentMask, uv_content);
	
	COLOR.rgb = base_tex.rgb;
	COLOR.a = container_tex.r * content_tex.r;
}