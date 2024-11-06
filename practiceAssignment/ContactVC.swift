//
//  ContactVC.swift
//  practiceAssignment
//
//  Created by TGPL-MACMINI-66 on 05/11/24.
//

import UIKit
import Alamofire
import IBAnimatable

class ContactVC: UIViewController {
    
    @IBOutlet weak var phoneNumber: AnimatableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup
        
        
    }
    
    
    @IBAction func continueBtn(_ sender: AnimatableButton) {
        applyContact()
    }
    
    func applyContact() {
            // Define the base URL and endpoint
            let url = "https://app.aisle.co/V1/users/phone_number_login"
            
            // Define the parameters
            let parameters: [String: String] = [
                "number": "+919876543212"
            ]
            
            // Make the POST request
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let status = json["status"] as? Int {
                        
                        if status == 1 {
                            print("Login successful!")
                            // Perform any additional actions needed on success
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                                
                                vc.contactNumber = self.phoneNumber.text!
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                        } else {
                            print("Login failed with status: \(status)")
                            // Handle different status codes or failure scenarios
                        }
                    } else {
                        print("Unexpected response format")
                    }
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
}

