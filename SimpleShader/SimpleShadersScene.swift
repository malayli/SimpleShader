//
//  SimpleShadersScene.swift
//  SimpleShader
//
//  Created by Malik, Alayli on 2019/10/16.
//  Copyright © 2019 Malik, Alayli. All rights reserved.
//

import SceneKit

final class SimpleShadersScene: SCNScene {
    enum ShaderType {
        case standard, enlighted, timelyColored
    }
    
    let shaderType: ShaderType = .timelyColored
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        switch shaderType {
        case .standard:
            let node = cubeNode(position: SCNVector3(0, 0, 0), shaders: [:])
            let program = SCNProgram()
            program.vertexFunctionName = "textureSamplerVertex"
            program.fragmentFunctionName = "textureSamplerFragment"
            node.geometry?.firstMaterial?.program = program
            guard let landscapeImage  = UIImage(named: "landscape") else {
              return
            }
            let materialProperty = SCNMaterialProperty(contents: landscapeImage)
            node.geometry?.firstMaterial?.setValue(materialProperty, forKey: "customTexture")
            rootNode.addChildNode(node)
            
        case .enlighted:
            let node = cubeNode(position: SCNVector3(0, 0, 0), shaders: [:])
            let program = SCNProgram()
            program.vertexFunctionName = "enlightedVertex"
            program.fragmentFunctionName = "enlightedFragment"
            node.geometry?.firstMaterial?.program = program
            guard let landscapeImage  = UIImage(named: "landscape") else {
              return
            }
            let materialProperty = SCNMaterialProperty(contents: landscapeImage)
            node.geometry?.firstMaterial?.setValue(materialProperty, forKey: "customTexture")
            rootNode.addChildNode(node)
            
        case .timelyColored:
            let node = cubeNode(position: SCNVector3(0, 0, 0), shaders: [.fragment: timelyColoredFragmentShader])
            rootNode.addChildNode(node)
        }
    }
}

private extension SimpleShadersScene {
    private func cubeNode(position p: SCNVector3, shaders: [SCNShaderModifierEntryPoint: String]) -> SCNNode {
        let node = SCNNode()
        node.castsShadow = false
        node.position = p
        node.geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.shaderModifiers = shaders
        material.lightingModel = .constant
        node.geometry?.materials = [material]
        
        return node
    }
}
