shader_type spatial;

render_mode blend_mix, depth_draw_always, cull_back, unshaded;

uniform vec4 albedo_color : source_color = vec4(0.5, 0.5, 0.5, 0.4);

void fragment() {
    ALBEDO = albedo_color.rgb;
    ALPHA = albedo_color.a;
}
