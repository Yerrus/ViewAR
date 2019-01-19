//
//  ViewController.swift
//  ViewAR
//
//  Created by Eugene Lee on 2019-01-13.
//  Copyright © 2019 Eugene Lee. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var ball = SCNNode()
    var box = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        let dummyNode = scene.rootNode.childNode(withName: "dummyNode", recursively: false)
        dummyNode?.position = SCNVector3(0, -5, -5)
        
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            if (node.name == "ball") {
                print ("found ball")
                ball = node
                ball.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node:ball, options:nil))
                ball.physicsBody?.isAffectedByGravity = true
                ball.physicsBody?.restitution = 1
                
            } else if (node.name == "ball") {
                print ("found box")
                box = node
                let boxGeometry = box.geometry
                let boxShape:SCNPhysicsShape = SCNPhysicsShape(geometry: boxGeometry!, options: nil)
                box.physicsBody = SCNPhysicsBody(type: .static, shape: boxShape)
                box.physicsBody?.restitution = 1
                
            }
        }
        
        let light = SCNLight()
        light.type = SCNLight.LightType.omni
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x:1.5, y:1.5, z:1.5)
        scene.rootNode.addChildNode(lightNode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
