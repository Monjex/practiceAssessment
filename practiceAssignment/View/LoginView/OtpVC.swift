//
//  OtpVC.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import UIKit
import Alamofire
import IBAnimatable

class OtpVC: UIViewController {

    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    var contactNumber : String?
    var viewModel = OtpViewModel()
    
    var timer: Timer?
    var totalTime = 60
    
   override func viewDidLoad() {
       super.viewDidLoad()
       
       phoneNumber.text = "+91 \(contactNumber ?? "")"
       viewModel.contactNumber = "+91" + (contactNumber ?? "")
       setupViewModelCallbacks()
       
       startOtpTimer()
       updateTimer()
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       timer?.invalidate()
       timer = nil
   }

  
  
    @IBAction func continueBtn(_ sender: AnimatableButton) {
        
        viewModel.otpCode = "1234" // Replace with user inputted OTP field if available
        viewModel.verifyOtp()
        
    }
    
    private func setupViewModelCallbacks() {
        viewModel.onVerificationSuccess = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeTBC") as! HomeTBC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

        viewModel.onVerificationFailure = { error in
            print("OTP verification failed: \(error)")
            // Optionally show alert
        }
    }

    private func startOtpTimer() {
        self.totalTime = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        self.timerLbl.text = self.timeFormatted(self.totalTime)
        if totalTime != 0 {
            totalTime -= 1
        } else {
            timer?.invalidate()
            timer = nil
        }
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%2d : %02d", minutes, seconds)
    }
}
