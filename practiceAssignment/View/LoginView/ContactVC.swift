//
//  ContactVC.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import UIKit
import Alamofire
import IBAnimatable

class ContactVC: UIViewController {
    
    @IBOutlet weak var phoneNumber: AnimatableTextField!
    
    private let viewModel = ContactViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup
        setupViewModelCallbacks()
        
    }
    
    @IBAction func continueBtn(_ sender: AnimatableButton) {
        guard let number = phoneNumber.text, !number.isEmpty else {
                    print("Please enter phone number")
                    return
                }
                
                viewModel.phoneNumber = "+91" + phoneNumber.text!
                viewModel.applyContact()
    }
    
    private func setupViewModelCallbacks() {
            viewModel.onLoginSuccess = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                    vc.contactNumber = self.phoneNumber.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }

            viewModel.onLoginFailure = { errorMessage in
                print("Login failed: \(errorMessage)")
                // Show alert if needed
            }
        }
}

