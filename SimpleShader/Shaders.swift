//
//  Shaders.swift
//  SimpleShader
//
//  Created by Malik, Alayli on 2019/10/25.
//  Copyright © 2019 Malik, Alayli. All rights reserved.
//

import Foundation

let timelyColoredFragmentShader = """
// Normalized pixel coordinates (from 0 to 1)
vec2 uv = gl_FragCoord.xy * u_inverseResolution.xy;

// Time varying pixel color
vec3 col = 0.5 + 0.5*cos(u_time+uv.xyx+vec3(0,2,4));

// Output to screen
_output.color.rgba = vec4(col,1);
"""

let gaussianFragment = """
vec2 uv = _surface.diffuseTexcoord.xy;

float xValue = u_inverseResolution.x * 3.0;
float yValue = u_inverseResolution.y * 2.0;

float blur = 5.2;

// Apply Gaussian Blur
vec3 col = texture2D(u_diffuseTexture, vec2(uv.x - 4.0 * xValue * blur, uv.y - 4.0 * yValue * blur)).rgb * 0.01621621621;
col += texture2D(u_diffuseTexture, vec2(uv.x - 3.0 * xValue * blur, uv.y - 3.0 * yValue * blur)).rgb * 0.0540540541;
col += texture2D(u_diffuseTexture, vec2(uv.x - 2.0 * xValue * blur, uv.y - 2.0 * yValue * blur)).rgb * 0.1216216216;
col += texture2D(u_diffuseTexture, vec2(uv.x - 1.0 * xValue * blur, uv.y - 1.0 * yValue * blur)).rgb * 0.1945945946;
col += texture2D(u_diffuseTexture, vec2(uv.x, uv.y)).rgb * 0.2270270270;
col += texture2D(u_diffuseTexture, vec2(uv.x + 1.0 * xValue * blur, uv.y + 1.0 * yValue * blur)).rgb * 0.1945945946;
col += texture2D(u_diffuseTexture, vec2(uv.x + 2.0 * xValue * blur, uv.y + 2.0 * yValue * blur)).rgb * 0.1216216216;
col += texture2D(u_diffuseTexture, vec2(uv.x + 3.0 * xValue * blur, uv.y + 3.0 * yValue * blur)).rgb * 0.0540540541;
col += texture2D(u_diffuseTexture, vec2(uv.x + 4.0 * xValue * blur, uv.y + 4.0 * yValue * blur)).rgb * 0.01621621621;

// Output to screen
_output.color.rgba = vec4(col,1);
"""
