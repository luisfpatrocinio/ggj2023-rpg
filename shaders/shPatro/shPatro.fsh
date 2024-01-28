//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    // Coleta a cor original da textura
    vec4 originalColor = texture2D(gm_BaseTexture, v_vTexcoord);

    // Converte a cor para uma escala de cinza
    float grayValue = (originalColor.r + originalColor.g + originalColor.b) / 3.0;

    // Ajusta a nova cor com base na escala de cinza
    vec4 grayColor = vec4(grayValue, grayValue, grayValue, originalColor.a);

    // Aplica a cor em preto e branco
    gl_FragColor = v_vColour * grayColor;
}