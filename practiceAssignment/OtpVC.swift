//
//  OtpVC.swift
//  practiceAssignment
//
//  Created by TGPL-MACMINI-66 on 05/11/24.
//

import UIKit
import Alamofire
import IBAnimatable

class OtpVC: UIViewController {

    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    var contactNumber : String?
    
    var token : String?
    
    var timer: Timer?
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        phoneNumber.text = "+91 \(contactNumber!)"
        
        startOtpTimer()
        updateTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    
    
    @IBAction func continueBtn(_ sender: AnimatableButton) {
        
        verifyOtp()
        
    }
    
    private func startOtpTimer() {
        self.totalTime = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

            
    @objc func updateTimer() {
        print(self.totalTime)
        self.timerLbl.text = self.timeFormatted(self.totalTime) // will show timer
            if totalTime != 0 {
                totalTime -= 1  // decrease counter timer
                
            } else {
                
                if let timer = self.timer {
                    timer.invalidate()
                    self.timer = nil
                }
            }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%2d : %02d", minutes, seconds)
    }
    
    func verifyOtp() {
            // Define the base URL and endpoint
            let url = "https://app.aisle.co/V1/users/verify_otp"
            
            // Define the parameters
            let parameters: [String: String] = [
                "number": "+919876543212",
                "otp" : "1234"
            ]
            
            // Make the POST request
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = value as? [String: Any]
                    if let token = json!["token"] as? String {
                                // Store the token using UserDefaults
                        self.token = token
                        print("Token stored successfully: \(String(describing: self.token))")
                        
                        UserDefaults.standard.set(token, forKey: "authToken")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeTBC") as! HomeTBC
                            //vc.authToken = self.token
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    } else {
                        print("Token not found in the response")
                    }
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    

}
