//
//  CameraViewController.swift
//  TheatreLink
//
//  Created by Natalie Meneses on 12/11/20.
//

import UIKit
import Parse
import AlamofireImage

class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
       

    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var ProfileImageView: UIImageView!
    
    static let profileImageUpdateNotification = Notification.Name(rawValue: "profileImageUpdateNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ProfileImageView.layer.cornerRadius = ProfileImageView.frame.size.height / 2.0
        self.ProfileImageView.clipsToBounds = true
      
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated:true, completion: nil)
    }
    
    func imagePickerController(_ _picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        ProfileImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func submitButton(_ sender: Any) {
        let changeProfile = PFObject(className: "Profile")
        
        changeProfile["description"] = descriptionField.text!
        changeProfile["author"] = PFUser.current()!
        
        let imageData = ProfileImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        changeProfile["image"] = file
        
        changeProfile.saveInBackground{  (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("saved!")
                NotificationCenter.default.post(name: CameraViewController.profileImageUpdateNotification, object: nil)
            }else{
                print("error!")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
