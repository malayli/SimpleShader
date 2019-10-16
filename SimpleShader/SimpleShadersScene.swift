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
        case standard, enlighted
    }
    
    let shaderType: ShaderType = .enlighted
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        let node = SCNNode()
        node.castsShadow = false
        node.position = SCNVector3(0, 0, 0)
        node.geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        rootNode.addChildNode(node)
        
        let program = SCNProgram()
        
        switch shaderType {
        case .standard:
            program.vertexFunctionName = "textureSamplerVertex"
            program.fragmentFunctionName = "textureSamplerFragment"
            
        case .enlighted:
            program.vertexFunctionName = "diffuseVertex"
            program.fragmentFunctionName = "diffuseFragment"
        }
        
        node.geometry?.firstMaterial?.program = program
        
        guard let landscapeImage  = UIImage(named: "landscape") else {
          return
        }
        let materialProperty = SCNMaterialProperty(contents: landscapeImage)
        node.geometry?.firstMaterial?.setValue(materialProperty, forKey: "customTexture")
    }
}
