#version 150

#moj_import <light.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in vec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightMapValue;
out vec2 texCoord0;
out vec2 texCoord1;
out vec4 normal;
out vec2 surfacePosition;
out vec3 position;
out vec4 clipPos;

flat out vec4 tint;
flat out vec3 vNormal;
flat out vec4 texel;

const vec2[] corners = vec2[](
    vec2(0, 1), vec2(0, 0), vec2(1, 0), vec2(1, 1)
);

void main() {
    vNormal = Normal;
    texel = texelFetch(Sampler2, UV2 / 16, 0);   
    
    clipPos = ProjMat * ModelViewMat * vec4(Position, 1.0);
    gl_Position = clipPos;
    position = Position;
    surfacePosition = corners[gl_VertexID % 4];
    
    vertexDistance = length((ModelViewMat * vec4(Position, 1.0)).xyz);
    lightMapValue = texelFetch(Sampler2, UV2 / 16, 0);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, vec4(1.0, 1.0, 1.0, 1.0));
    tint = Color;
    texCoord0 = UV0;
    texCoord1 = UV1;
    normal = ModelViewMat * vec4(Normal, 0.0);
}
