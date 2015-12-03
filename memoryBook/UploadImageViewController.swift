//
//  UploadImageViewController.swift
//  ParseTutorial
//
//  Created by Ron Kliffer on 3/6/15.
//  sCopyright (c) 2015 Ron Kliffer. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate {
  
  @IBOutlet weak var imageToUpload: UIImageView!
  @IBOutlet weak var commentTextField: UITextField!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
   // var locValue: PFGeoPoint
  var username: String?
    var location: PFGeoPoint?
    let locationManager = CLLocationManager()
var locations: [CLLocation] = []
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.requestAlwaysAuthorization()
    
    // For use in foreground
    locationManager.requestWhenInUseAuthorization()
   
    if CLLocationManager.locationServicesEnabled() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    // Do any additional setup after loading the view.
  }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
  
  // MARK: - Actions
  @IBAction func selectPicturePressed(sender: AnyObject) {
    //Open a UIImagePickerController to select the picture
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    presentViewController(imagePicker, animated: true, completion: nil)
  }
  

  
  @IBAction func sendPressed(sender: AnyObject) {
    commentTextField.resignFirstResponder()
    
    //Disable the send button until we are ready
    navigationItem.rightBarButtonItem?.enabled = false
    
    loadingSpinner.startAnimating()
    
    //TODO: Upload a new picture
    let pictureData = UIImageJPEGRepresentation(imageToUpload.image!,1)
    
    //1
    let file = PFFile(name: "imageFile", data: pictureData!)
    file!.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
      if succeeded {
        //2
        self.saveMemory(file!)
        self.performSegueWithIdentifier("UploadtoProfile", sender: self)
      } else if let error = error {
        //3
        self.showErrorView(error)
      }
      }, progressBlock: { percent in
        //4
        print("Uploaded: \(percent)%")
    })
  }
  
  func saveMemory(file: PFFile)
  {
    var point = PFGeoPoint(latitude:40.0, longitude:-30.0)
    
    //1
    let Memory = memory(imageFile: file, userName: PFUser.currentUser()!, desc: self.commentTextField.text, location:point)    //2
    
    Memory.saveInBackgroundWithBlock{ succeeded, error in
      if succeeded {
        //3
        self.navigationController?.popViewControllerAnimated(true)
      } else {
        //4
        if let errorMessage = error?.userInfo["error"] as? String {
          self.showErrorView(error!)
        }
      }
    }
  }
  

  
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageToUpload.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
