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
    
    static var sharedInstance: ARWindowViewController!
    
    private var videoPlayer: AVPlayer = AVPlayer(url: Bundle.main.url(forResource: "SunsetShanghai", withExtension: ".mov")!)
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
    
//    private func prepareFloatingCard(for physicalSize: CGSize) -> UIImage {
//        let floatingCardnib = UINib(nibName: "ARFloatingCardView", bundle: Bundle.main)
//        let floatingCardView = floatingCardnib.instantiate(withOwner: self, options: nil).first
//            as! ARFloatingCardView
//        print(floatingCardView.frame)
//        floatingCardView.setupTitle(with: currentTrackingPhoto?.photoTitle ?? "Nothing to show.")
//        let imageSize = CGSize(width: physicalSize.width * 1000, height: physicalSize.height * 1000)
//        return floatingCardView.viewImage(for: imageSize)!
//    }

}


extension ARWindowViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor {
            let imageSize = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: imageSize.width, height: imageSize.height)
            plane.firstMaterial?.diffuse.contents = self.videoPlayer
            self.videoPlayer.play()
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            let phoneScene = SCNScene(named: "Phone_01.scn")
            let phoneNode = phoneScene?.rootNode.childNode(withName: "parentNode", recursively: true)!
            phoneNode?.position = SCNVector3Zero
            phoneNode?.position.z = 0.15
            phoneNode?.position.y += Float(imageSize.height)
            let rotationAction = SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)
            let inifiniteAction = SCNAction.repeatForever(rotationAction)
            phoneNode?.scale = SCNVector3(0.02, 0.02, 0.02)
            phoneNode!.runAction(inifiniteAction)
            node.addChildNode(phoneNode!)
        }
        return node
    }
    
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        if let planeAnchor = anchor as? ARImageAnchor {
//            let width = CGFloat(planeAnchor.referenceImage.physicalSize.width)
//            let height = CGFloat(planeAnchor.referenceImage.physicalSize.height)
//            let plane = SCNPlane(width: width, height: height)
//            plane.materials.first?.diffuse.contents = UIImage(named: "FloatCard")
//            plane.cornerRadius = 0.01
//            let planeNode = SCNNode(geometry: plane)
//            var somePosition = node.position
//            somePosition.z += Float(planeAnchor.referenceImage.physicalSize.height) + 0.02
//            planeNode.position = somePosition
//            planeNode.eulerAngles.x = -.pi / 2
//            planeNode.eulerAngles.y = -.pi
//            node.addChildNode(planeNode)
//        }
//    }
}
