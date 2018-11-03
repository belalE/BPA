//
//  CreateProfileViewController.swift
//  BPA
//
//  Created by Belal Elsiesy on 11/2/18.
//  Copyright © 2018 Elsiesy Industries. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CreateProfileViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var feetTextField: UITextField!
    @IBOutlet weak var inchesTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    private var datePicker: UIDatePicker?
    let db = Firestore.firestore()
    var profileImage : UIImage?

    var ref: DocumentReference? = nil
   
    var uid:String?
    var g = ""
    var picker = UIPickerView()
    var data = ["Losing weight", "Gain muscle","Get lean","increase strength","increase stamina"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        dateTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(self.dateChanged(datePicker:)), for: .valueChanged)
        // Set up goal picker 
        picker.delegate = self
        picker.dataSource = self
        goalTextField.inputView = picker
        // Do any additional setup after loading the view.
        profileImageView.isUserInteractionEnabled = true
        
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.singleTapping(recognizer: )))
        singleTap.numberOfTapsRequired = 1;
        profileImageView.addGestureRecognizer(singleTap)
        
        self.view.addSubview(profileImageView)
    }
    @objc func singleTapping(recognizer: UIGestureRecognizer) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage = image
            profileImageView.image = image
        } else {
            //error message

        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func dateChanged(datePicker:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // returns the # of rows in each component..

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        goalTextField.text = data[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let f = firstNameTextField.text, let l = lastNameTextField.text, let goal = goalTextField.text,let date = dateTextField.text, let w = weightTextField.text, let feet = Int(feetTextField.text!), let inches = Int(inchesTextField.text!) {
            if genderSegmentedControl.selectedSegmentIndex == 0 {
                g = "m"
            } else {g = "f"}
            db.collection("users").document(uid!).setData(["first name": f,"last name" : l, "goal": goal,"date of birth" : date, "weight": w, "height": 12*feet+inches,"gender": g]){ err in
                if let err = err {
                    print("Error adding document : \(err)")
                } else {
                    print("Document added with ID: \(String(describing: self.uid))")
                }
                
            }
        }
    }
    
}
