shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 50.0) = 10.0; // Altura de la onda
uniform float frequency : hint_range(0.0, 10.0) = 2.0;  // Frecuencia de la onda
uniform float speed : hint_range(0.0, 10.0) = 1.0;      // Velocidad de la onda
uniform float edge_fade : hint_range(0.0, 1.0) = 0.1;   // Factor para suavizar la onda en los bordes

void fragment() {
    // Calcula la distorsión en el eje Y usando una función seno
    float wave = sin(UV.x * frequency + TIME * speed) * amplitude;

    // Suaviza la onda cerca de los bordes superior e inferior
    float fade_factor = smoothstep(0.0, edge_fade, UV.y) * smoothstep(0.0, edge_fade, 1.0 - UV.y);

    // Aplica la distorsión al UV.y con el factor de suavizado
    vec2 distorted_uv = vec2(UV.x, clamp(UV.y + 0.1 * wave * fade_factor / TEXTURE_PIXEL_SIZE.y, 0.0, 1.0));

    // Muestra el color de la textura en la posición distorsionada
    COLOR = texture(TEXTURE, distorted_uv);
}
