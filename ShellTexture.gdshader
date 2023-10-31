shader_type spatial;

uniform float threshold = 0.1;
uniform float strands = 100;
uniform float height = 1;
uniform vec3 color : source_color;

// Hash from https://www.shadertoy.com/view/ttc3zr
uint murmurHash(uvec2 src) {
    const uint M = 0x5bd1e995u;
    uint h = 1190494759u;
    src *= M; src ^= src>>24u; src *= M;
    h *= M; h ^= src.x; h *= M; h ^= src.y;
    h ^= h>>13u; h *= M; h ^= h>>15u;
    return h;
}

// 1 output, 2 inputs
float hash(vec2 src) {
    uint h = murmurHash(floatBitsToUint(src));
    return uintBitsToFloat(h & 0x007fffffu | 0x3f800000u) - 1.0;
}

// end hash functions

float inverseLerp(float t, float to, float from) {
	return (t - from) / (to - from);
}



void vertex() {
	VERTEX += NORMAL * height;
}

void fragment() {
	
	vec2 strandUV = fract(UV * strands);
	vec2 centeredStrandUV = strandUV - 0.5;
	vec2 discreteUV = floor(UV * strands) / strands;
	float noiseValue = hash(discreteUV);
	if (noiseValue < threshold || (length(centeredStrandUV) > 0.5 * (1. - threshold) && height > 0.)) {
		discard;
	}
		ALBEDO = mix(vec3(0),color,threshold);
}


