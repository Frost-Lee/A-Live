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
    
    static var sharedInstance: ARWindowViewController!
    
    var currentAlbum: Album? {
        didSet {
            currentTrackingPhoto = currentAlbum?.contains?.first(where: {_ in return true}) as? Photo
        }
    }
    var currentTrackingPhoto: Photo? {
        didSet {
            currentTrackingPhotoChanged()
        }
    }
    
    private var videoPlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ARWindowViewController.sharedInstance = self
        sceneView.delegate = self
    }
    
    private func currentTrackingPhotoChanged() {
        if let photo = currentTrackingPhoto {
            if let videoPath = photo.liveVideoPath {
                videoPlayer = AVPlayer(url: URL(fileURLWithPath: videoPath))
                setupARConfiguration(with: [ALDataManager.defaultManager.fetchPhoto(with: photo.photoPath!)])
            }
        }
    }
    
    private func setupARConfiguration(with images: [UIImage]) {
        let configuration = ARImageTrackingConfiguration()
        var imageSet = Set<ARReferenceImage>()
        for image in images {
            let referenceImage = ARReferenceImage(image.cgImage!, orientation: .up, physicalWidth: 0.2)
            imageSet.insert(referenceImage)
        }
        configuration.trackingImages = imageSet
        configuration.maximumNumberOfTrackedImages = images.count
        sceneView.session.run(configuration)
    }
    
    private func prepareFloatingCard() -> UIImage {
        let floatingCardnib = UINib(nibName: "ARFloatingCardView", bundle: Bundle.main)
        let floatingCardView = floatingCardnib.instantiate(withOwner: self, options: nil).first as! ARFloatingCardView
        floatingCardView.setupTitle(with: currentTrackingPhoto?.photoTitle ?? "Nothing to show.")
        return floatingCardView.viewImage()!
    }

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
        }
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARImageAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.referenceImage.physicalSize.width / 2.0)
        let height = CGFloat(planeAnchor.referenceImage.physicalSize.width / 2.0)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = prepareFloatingCard()
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.referenceImage.physicalSize.width)
        let y = CGFloat(planeAnchor.referenceImage.physicalSize.width)
        let z = CGFloat(0)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
    }
}
