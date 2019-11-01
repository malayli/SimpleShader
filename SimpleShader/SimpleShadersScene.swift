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
        case standard, enlighted, timelyColored, gaussianBlurred, discovery
    }
    
    let shaderType: ShaderType = .discovery
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        switch shaderType {
        case .standard:
            let node = SCNNode(position: SCNVector3(0, 0, 0), shaders: [:])
            node.addProgram(vertexFunctionName: "textureSamplerVertex",
                            fragmentFunctionName: "textureSamplerFragment")
            node.addMaterialWithTexture("landscape", for: "customTexture")
            rootNode.addChildNode(node)
            
        case .enlighted:
            let node = SCNNode(position: SCNVector3(0, 0, 0), shaders: [:])
            node.addProgram(vertexFunctionName: "enlightedVertex",
                            fragmentFunctionName: "enlightedFragment")
            node.addMaterialWithTexture("landscape", for: "customTexture")
            rootNode.addChildNode(node)
            
        case .timelyColored:
            let node = SCNNode(position: SCNVector3(0, 0, 0), shaders: [.fragment: timelyColoredFragmentShader])
            rootNode.addChildNode(node)
                
        case .gaussianBlurred:
            let node = SCNNode(position: SCNVector3(0, 0, 0), shaders: [.fragment: gaussianFragment])
            node.addTexture("landscape")
            rootNode.addChildNode(node)
            
        case .discovery:
            let node = SCNNode(position: SCNVector3(0, 0, 0), shaders: [.fragment: discoveringFragment])
            node.addTexture("landscape")
            rootNode.addChildNode(node)
        }
    }
}

// MARK: - Cube

extension SCNNode {
    convenience init(position p: SCNVector3, shaders: [SCNShaderModifierEntryPoint: String]) {
        self.init()
        
        castsShadow = false
        position = p
        geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.shaderModifiers = shaders
        material.lightingModel = .constant
        geometry?.materials = [material]
    }
}

// MARK: - Texture

extension SCNNode {
    func addTexture(_ imageName: String) {
        geometry?.firstMaterial?.diffuse.contents = UIImage(named: imageName)
    }
    
    func addProgram(vertexFunctionName: String, fragmentFunctionName: String) {
        let program = SCNProgram()
        program.vertexFunctionName = vertexFunctionName
        program.fragmentFunctionName = fragmentFunctionName
        geometry?.firstMaterial?.program = program
    }
    
    func addMaterialWithTexture(_ name: String, for key: String) {
        guard let customTextureImage  = UIImage(named: name) else {
            return
        }
        let materialProperty = SCNMaterialProperty(contents: customTextureImage)
        geometry?.firstMaterial?.setValue(materialProperty, forKey: key)
    }
}
