//
//  AddAlbumViewController.swift
//  A·Live
//
//  Created by 李灿晨 on 2018/8/3.
//  Copyright © 2018 李灿晨. All rights reserved.
//

import UIKit

class AddAlbumViewController: UIViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var keyPhotoImageView: UIImageView!
    @IBOutlet weak var albumTitleTextField: UITextField!
    @IBOutlet weak var albumDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.isEnabled = false
        keyPhotoImageView.clipsToBounds = true
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        ALDataManager.defaultManager.createAlbum(titled: albumTitleTextField.text!,
                keyPhoto: keyPhotoImageView.image!, description: albumDescriptionTextField.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addKeyPhotoButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func albumTitleTextFieldChanged(_ sender: UITextField) {
        if albumTitleTextField.text?.count != 0 {
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
}


extension AddAlbumViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
        info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        keyPhotoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
