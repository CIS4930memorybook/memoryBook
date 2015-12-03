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
    
    let locationManager = CLLocationManager()
var locations: [CLLocation] = []
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    super.viewDidLoad()
    
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
    
    // Do any additional setup after loading the view.
  }
    var latitude: Double!
    var longitude: Double!
    var location: CLLocation!
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
         location = locations.last
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
         latitude = location!.coordinate.latitude
         longitude = location!.coordinate.longitude
        print(latitude)
        print(longitude)
        
        //let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        //self.mapView.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
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
    
    var point = PFGeoPoint(latitude:location!.coordinate.latitude, longitude:location!.coordinate.longitude)

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
