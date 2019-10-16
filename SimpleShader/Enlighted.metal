#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct Light
{
    float3 direction;
    float3 ambientColor;
    float3 diffuseColor;
    float3 specularColor;
};

constant Light light = {
    .direction = { 0.13, 0.72, 0.68 },
    .ambientColor = { 0.05, 0.05, 0.05 },
    .diffuseColor = { 1, 1, 1 },
    .specularColor = { 0.2, 0.2, 0.2 }
};

constant float3 kSpecularColor= { 1, 1, 1 };
constant float kSpecularPower = 80;

struct NodeBuffer {
  float4x4 modelTransform;
  float4x4 modelViewProjectionTransform;
  float4x4 modelViewTransform;
  float3x3 normalTransform;
  float2x3 boundingBox;
};

struct Vertex
{
    float4 position [[attribute(SCNVertexSemanticPosition)]];
    float3 normal [[attribute(SCNVertexSemanticNormal)]];
    float2 texCoords [[attribute(SCNVertexSemanticTexcoord0)]];
};

struct ProjectedVertex
{
    float4 position [[position]];
    float3 eyePosition;
    float3 normal;
    float2 texCoords;
};

vertex ProjectedVertex enlightedVertex(Vertex vert [[stage_in]], constant NodeBuffer& scn_node [[buffer(1)]])
{
    ProjectedVertex outVert;
    outVert.position = scn_node.modelViewProjectionTransform * vert.position;
    outVert.eyePosition = -(scn_node.modelViewTransform * vert.position).xyz;
    outVert.normal = scn_node.normalTransform * vert.normal;
    outVert.texCoords = vert.texCoords;
    return outVert;
}

fragment float4 enlightedFragment(ProjectedVertex vert [[stage_in]], texture2d<float, access::sample> customTexture [[texture(0)]])
{
    constexpr sampler samplr(coord::normalized, filter::linear, address::repeat);
    float3 diffuseColor = customTexture.sample(samplr, vert.texCoords).rgb;
    float3 ambientTerm = light.ambientColor * diffuseColor;
    float3 normal = normalize(vert.normal);
    float diffuseIntensity = saturate(dot(normal, light.direction));
    float3 diffuseTerm = light.diffuseColor * diffuseColor * diffuseIntensity;
    float3 specularTerm(0);
    
    if (diffuseIntensity > 0)
    {
        float3 eyeDirection = normalize(vert.eyePosition);
        float3 halfway = normalize(light.direction + eyeDirection);
        float specularFactor = pow(saturate(dot(normal, halfway)), kSpecularPower);
        specularTerm = light.specularColor * kSpecularColor * specularFactor;
    }
    
    return float4(ambientTerm + diffuseTerm + specularTerm, 1);
}
