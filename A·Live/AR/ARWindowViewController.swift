//
//  ARWindowViewController.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/1.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit
import ARKit

class ARWindowViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var darkBackgroundBlurView: UIVisualEffectView!
    @IBOutlet weak var currentAlbumTitleLabel: UILabel!
    
    static var sharedInstance: ARWindowViewController!
    private var videoPlayer: AVPlayer = AVPlayer(url: Bundle.main.url(forResource: "EPXi", withExtension: ".mov")!)
    private var trackingImageSet: Set<ARReferenceImage> = ARReferenceImage.referenceImages(inGroupNamed: "DemoResources", bundle: Bundle.main)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ARWindowViewController.sharedInstance = self
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupARConfiguration()
    }
    
    private func setupARConfiguration() {
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = trackingImageSet
        configuration.maximumNumberOfTrackedImages = trackingImageSet.count
        sceneView.session.run(configuration)
    }
    
    private func hideDarkBackground() {
        UIView.animate(withDuration: 0.2, delay: 0, options:
            UIView.AnimationOptions.curveEaseInOut, animations: {
                self.darkBackgroundBlurView.alpha = 0
        }, completion: nil)
    }

}


extension ARWindowViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let imageSize = imageAnchor.referenceImage.physicalSize
            if imageAnchor.referenceImage.name == "EmperorXi" {
                let plane = SCNPlane(width: imageSize.width, height: imageSize.height)
                plane.firstMaterial?.diffuse.contents = self.videoPlayer
                self.videoPlayer.play()
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi / 2
                node.addChildNode(planeNode)
            } else if imageAnchor.referenceImage.name == "Pixel" {
                let phoneScene = SCNScene(named: "Phone_01.scn")
                let phoneNode = phoneScene?.rootNode.childNode(withName: "parentNode", recursively: true)!
                phoneNode?.position = SCNVector3Zero
                phoneNode?.position.y = 0.05
                phoneNode?.position.z += Float(imageSize.height) / 2.0
                let adjustRotation = SCNAction.rotateBy(x: -.pi / 2, y: 0, z: 0, duration: 0.01)
                phoneNode?.runAction(adjustRotation)
                let rotationAction = SCNAction.rotateBy(x: 0, y: 0, z: 0.5, duration: 1)
                let inifiniteAction = SCNAction.repeatForever(rotationAction)
                phoneNode?.scale = SCNVector3(0.015, 0.015, 0.015)
                phoneNode!.runAction(inifiniteAction)
                node.addChildNode(phoneNode!)
            }
        }
        return node
    }
}
