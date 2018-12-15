//
//  ViewController.swift
//  Tracker
//
//  Created by Carlos Mendez on 11/23/18.
//  Copyright © 2018 Carlos Mendez. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgPhotoImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var student: StudentModel?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = txtName.text ?? ""
        let photo = imgPhotoImageView.image
        
        student = StudentModel(name: name, photo: photo)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = txtName.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.delegate = self
        updateSaveButtonState()
    }

    @IBAction func btnSetName(_ sender: UIButton) {
        lblName.text = txtName.text
        txtName.text = ""
    }
    
    @IBAction func selectImageGesture(_ sender: UITapGestureRecognizer) {
     
        // Hide the keyboard.
        txtName.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        imgPhotoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)

    }
}


