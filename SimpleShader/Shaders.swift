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
