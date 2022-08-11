//
//  ViewController.swift
//  App
//
//  Created by 髙津悠樹 on 2022/08/06.
//
import UIKit
import Firebase
import FirebaseStorageUI
import FirebaseAuth
import CropViewController
import FirebaseFirestore


class ViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CropViewControllerDelegate{
    
    
    
    @IBOutlet weak var imageViewpicker: UIImageView!
    
    
    //upload firebase storage
    @IBAction func uploadImageButton(){
     //   print("アップロードされました")
        
        uploadImage()
        print("tapped")
    }
    
    //use cropViewController
    @IBAction func imagecropping(_ sender: Any) {
    }
    
    //use iPhone Camera
    @IBAction func camerabutton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController,animated: true,completion: nil)
    }
    
    
    @IBOutlet weak var uplaodimagebutton2: UIButton!
    
    
    @IBOutlet weak var takepicture: UIButton!
    
    @IBOutlet var imagecroppingoutlet: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        uplaodimagebutton2.layer.cornerRadius = 10.0
        takepicture.layer.cornerRadius = 10.0
    }
    
    //upload firebase storage
    func uploadImage(){
        let storageref = Storage.storage().reference(forURL: "gs://loadimage-9bac0.appspot.com/").child("post")
        
        let image = imageViewpicker.image!
//        "hoge.jpeg"
        
        let data = image.jpegData(compressionQuality: 1.0)! as NSData
        //              !
        storageref.putData(data as Data, metadata: nil) { (data, error) in
            if error != nil {
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
        
    //unuse
    func loadImage(){
        let storageref = Storage.storage().reference(forURL: "gs://loadimage-9bac0.appspot.com/").child("post")
        
        imageViewpicker.sd_setImage(with: storageref)
    }
    
    
    func imagePickerController(_ picker:UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        imageViewpicker.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func setImagePicker(){
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true, completion: nil)
            
        }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
           updateImageViewWithImage(image, fromCropViewController: cropViewController)
       }
           
       func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
           imageViewpicker.image = image
           cropViewController.dismiss(animated: true, completion: nil)
       }

       func imagePickerController2(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           let image = info[.originalImage] as! UIImage
           guard let pickerImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
           
           let cropController = CropViewController(croppingStyle: .default, image: pickerImage)
           cropController.delegate = self
           cropController.customAspectRatio = CGSize(width: 100, height: 100)
           
           //今回は使わないボタン等を非表示にする。
           cropController.aspectRatioPickerButtonHidden = true
           cropController.resetAspectRatioEnabled = true
           cropController.rotateButtonsHidden = true
           
           //cropBoxのサイズを固定する。
           cropController.cropView.cropBoxResizeEnabled = true
           //pickerを閉じたら、cropControllerを表示する。
           picker.dismiss(animated: true) {
               self.present(cropController, animated: true, completion: nil)
           }
       }
        


}


