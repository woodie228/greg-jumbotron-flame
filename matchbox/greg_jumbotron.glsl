#version 120

uniform sampler2D input1;

uniform float adsk_result_w;
uniform float adsk_result_h;

uniform int output_mode;
uniform float pixel_pitch;
uniform float led_size;
uniform float grid_darkness;
uniform float scanline_strength;
uniform float scanline_spacing;
uniform float triad_amount;
uniform float flicker_amount;
uniform float animation_phase;
uniform float refresh_band;
uniform float refresh_width;
uniform float moire_amount;
uniform float edge_bloom;
uniform float contrast;
uniform float saturation;
uniform float brightness;
uniform float mix_amount;
uniform bool preserve_alpha;

float saturate(float value)
{
    return clamp(value, 0.0, 1.0);
}

vec2 saturate(vec2 value)
{
    return clamp(value, vec2(0.0), vec2(1.0));
}

vec3 saturate(vec3 value)
{
    return clamp(value, vec3(0.0), vec3(1.0));
}

vec4 sample_input(vec2 uv)
{
    return texture2D(input1, clamp(uv, vec2(0.0), vec2(1.0)));
}

float luminance(vec3 color)
{
    return dot(color, vec3(0.2126, 0.7152, 0.0722));
}

float hash12(vec2 p)
{
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 adjust_saturation(vec3 color, float amount)
{
    float luma = luminance(color);
    return mix(vec3(luma), color, amount);
}

vec3 soft_bloom(vec2 uv, vec2 texel)
{
    vec3 sum = sample_input(uv).rgb * 0.28;
    sum += sample_input(uv + vec2(texel.x, 0.0)).rgb * 0.12;
    sum += sample_input(uv - vec2(texel.x, 0.0)).rgb * 0.12;
    sum += sample_input(uv + vec2(0.0, texel.y)).rgb * 0.12;
    sum += sample_input(uv - vec2(0.0, texel.y)).rgb * 0.12;
    sum += sample_input(uv + texel).rgb * 0.07;
    sum += sample_input(uv - texel).rgb * 0.07;
    sum += sample_input(uv + vec2(texel.x, -texel.y)).rgb * 0.07;
    sum += sample_input(uv + vec2(-texel.x, texel.y)).rgb * 0.07;
    return sum;
}

void main()
{
    vec2 resolution = vec2(max(adsk_result_w, 1.0), max(adsk_result_h, 1.0));
    vec2 uv = gl_FragCoord.xy / resolution;
    vec2 pixel_pos = gl_FragCoord.xy;
    vec4 source = sample_input(uv);

    float pitch = max(pixel_pitch, 1.0);
    vec2 cell_id = floor(pixel_pos / pitch);
    vec2 cell_uv = fract(pixel_pos / pitch);
    vec2 cell_center_uv = (cell_id + vec2(0.5)) * pitch / resolution;

    vec4 cell_source = sample_input(cell_center_uv);
    vec3 color = cell_source.rgb;

    float led_radius = max(led_size, 0.001);
    vec2 centered = (cell_uv - vec2(0.5)) / led_radius;
    float led_dot = 1.0 - smoothstep(0.82, 1.08, length(centered));
    float square_led = 1.0 - smoothstep(0.45, 0.52, max(abs(cell_uv.x - 0.5), abs(cell_uv.y - 0.5)) / led_radius);
    float led_mask = mix(square_led, led_dot, 0.62);
    float grid_mask = mix(1.0 - saturate(grid_darkness), 1.0, led_mask);

    float scan_spacing = max(scanline_spacing, 1.0);
    float scan_phase = animation_phase * 6.28318531;
    float scanline = 0.5 + 0.5 * sin((pixel_pos.y / scan_spacing) * 6.28318531 + scan_phase);
    float scan_mask = mix(1.0, mix(0.58, 1.12, scanline), saturate(scanline_strength));

    float sub_x = fract(cell_uv.x * 3.0);
    float sub_index = floor(cell_uv.x * 3.0);
    float sub_soft = smoothstep(0.08, 0.28, sub_x) * (1.0 - smoothstep(0.72, 0.94, sub_x));
    vec3 triad = vec3(0.25);
    triad.r = sub_index < 1.0 ? 1.0 : 0.25;
    triad.g = (sub_index >= 1.0 && sub_index < 2.0) ? 1.0 : 0.25;
    triad.b = sub_index >= 2.0 ? 1.0 : 0.25;
    triad = mix(vec3(1.0), mix(vec3(0.25), triad, sub_soft), saturate(triad_amount));

    float noise = hash12(cell_id + vec2(animation_phase * 37.0, animation_phase * 11.0));
    float flicker = mix(1.0, mix(0.86, 1.16, noise), saturate(flicker_amount));

    float band_center = fract(animation_phase);
    float band_dist = abs(fract(uv.y - band_center + 0.5) - 0.5);
    float band = 1.0 - smoothstep(refresh_width, refresh_width + 0.08, band_dist);
    float refresh = mix(1.0, 1.0 + band * 0.38, saturate(refresh_band));

    float moire_a = sin((pixel_pos.x + pixel_pos.y * 0.37) * 0.47 + scan_phase * 0.47);
    float moire_b = sin((pixel_pos.x * 0.29 - pixel_pos.y * 0.61) + scan_phase * 0.31);
    float moire = 1.0 + (moire_a * moire_b) * 0.08 * saturate(moire_amount);

    vec2 texel = 1.0 / resolution;
    vec3 bloom = soft_bloom(uv, texel * pitch * 0.32);
    float bright_edge = saturate(luminance(bloom) - luminance(color));
    color += bloom * bright_edge * edge_bloom;

    color = (color - vec3(0.5)) * contrast + vec3(0.5);
    color = adjust_saturation(color, saturation);
    color *= brightness;

    vec3 screen_texture = vec3(grid_mask) * scan_mask * triad * flicker * refresh * moire;
    vec3 jumbotron = color * screen_texture;
    vec3 matte = vec3(saturate(led_mask * scan_mask));
    vec3 texture_view = saturate(screen_texture);
    vec3 output_color = mix(source.rgb, saturate(jumbotron), saturate(mix_amount));

    if (output_mode == 1) {
        output_color = saturate(jumbotron);
    } else if (output_mode == 2) {
        output_color = texture_view;
    } else if (output_mode == 3) {
        output_color = matte;
    } else if (output_mode == 4) {
        output_color = cell_source.rgb;
    }

    float alpha = preserve_alpha ? source.a : mix(source.a, cell_source.a, saturate(mix_amount));
    gl_FragColor = vec4(output_color, alpha);
}
