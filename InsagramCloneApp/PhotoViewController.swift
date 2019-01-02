//
//  PhotoViewController.swift
//  InsagramCloneApp
//
//  Created by Perez Willie Nwobu on 12/2/18.
//  Copyright © 2018 Perez Willie Nwobu. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var shareButtn: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var photo: UIImageView!
    var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
addGestures()
          photo.image?.accessibilityIdentifier = AccesbilityIdentifiers.oldImage.rawValue
    }
    
    @IBAction func shareButtnTapped(_ sender: Any) {
        
    }
    
    //gestureRecognizer
    private func addGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPostImage))
        photo.addGestureRecognizer(tapGesture)
         photo.isUserInteractionEnabled = true
    }
    
    
   @objc func handleSelectPostImage(){
    let pickerController = UIImagePickerController()
    pickerController.delegate = self
    present(pickerController, animated:  true, completion: nil)
    }
    
}

extension PhotoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        selectedImage = image
        photo.image = image
        photo.image?.accessibilityIdentifier = AccesbilityIdentifiers.newImage.rawValue
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
