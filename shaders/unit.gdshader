shader_type canvas_item;

uniform vec4 tint;
uniform bool selected;

void fragment() {
    vec4 highlight_tint = tint + vec4(0.5, 0.5, 0.5, 0.0);
    vec4 final_tint = mix(tint, highlight_tint, float(selected));

    COLOR = final_tint;
    COLOR.a = texture(TEXTURE, UV).a;
}