//
//  ViewController.swift
//  ARKIT-Sample
//
//  Created by Guilherme Wahlbrink on 2019-05-21.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var sphere = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        //sceneView.debugOptions = [.showWorldOrigin] // this is for debugging
        
        sceneView.autoenablesDefaultLighting = true
        // Create a new scene
        
        // Set the scene to the view
    }
    
    
    func drawSphereAtOrigin() {
        
        
        
        // SCNNode
        sphere = SCNNode(geometry: SCNSphere(radius: 0.05)) // 0.05 meters
        
        // set color of sphere
        sphere.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        // set reflection
        sphere.geometry?.firstMaterial?.specular.contents = UIColor.white
        // position
        sphere.position = SCNVector3(0,0,0)
        // add as ChildNode tp the Scene's rootNode
        sceneView.scene.rootNode.addChildNode(sphere)
        
        
        // angles -> radians (360 degrees -> 2 * pi radians)
        // rotation -> + positive ( counterclock wise) - negative (clock wise)
        let rotate = SCNAction.rotate(by: 2 * .pi, around: SCNVector3(0, 1, 0), duration: 5) // 5 seconds, arround Y Axis
        sphere.runAction(SCNAction.repeatForever(rotate)) // run indefinitely
    
        
    }
    
    func movingSpaceShip() {
        let scene = SCNScene(named: "art.scnassets/ship.scn")
        // extract spaceship from .scn file
        let spaceship = (scene?.rootNode.childNode(withName: "ship", recursively: false))!
        spaceship.position = SCNVector3(0.5, 0, 0)
        spaceship.scale = SCNVector3(0.2, 0.2, 0.2)
        // rotate the spaceship -> eulerAngle
        
        spaceship.eulerAngles.y = .pi // 180
        
        
        // add it to earch node
        sphere.addChildNode(spaceship)
    }
    
    
    func drawDonut() {
        let torus = SCNNode(geometry: SCNTorus(ringRadius: 0.05, pipeRadius: 0.03))
        torus.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        torus.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        
        torus.position = SCNVector3(0.3, 0, 0)
        torus.eulerAngles.x = .pi/2 // 90 degrees
        sceneView.scene.rootNode.addChildNode(torus)
    }
    
    func drawCarnival() {
        let plane = SCNNode(geometry: SCNPlane(width: 1, height: 1))
        plane.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "carnival")
        plane.geometry?.firstMaterial?.isDoubleSided = true
        plane.position = SCNVector3(1, 0, -2)
        sceneView.scene.rootNode.addChildNode(plane)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        
        drawSphereAtOrigin()
        movingSpaceShip()
        drawDonut()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
