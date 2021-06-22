//
//  PhotoCameraViewController.swift
//  Mynewproyect
//
//  Created by Alexis Omar Marquez Castillo on 15/04/21.
//  Copyright © 2021 udacity. All rights reserved.
//

import UIKit
import CoreData


class PhotoCameraViewController: UIViewController {

    @IBOutlet weak var takePhoto: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = .secondarySystemBackground
        takePhoto.backgroundColor = .systemBlue
        takePhoto.setTitle("Take photo", for: .normal)
        takePhoto.setTitleColor(.white, for: .normal)

    }
    
    @IBAction func taheThePhoto(_ sender: Any) {
        let pickerPhoto = UIImagePickerController()
        pickerPhoto.sourceType = .camera
        pickerPhoto.delegate = self
        present(pickerPhoto, animated: true)
    }
    
}
extension PhotoCameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
   picker.dismiss(animated: true, completion: nil)
   guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
return
}
    imageView.image = image
}
}
