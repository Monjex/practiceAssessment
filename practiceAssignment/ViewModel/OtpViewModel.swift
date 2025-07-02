//
//  OtpViewModel.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import Foundation
import Alamofire

class OtpViewModel {
    
    var contactNumber: String?
    var otpCode: String?
    
    var onVerificationSuccess: (() -> Void)?
    var onVerificationFailure: ((String) -> Void)?
    
    func verifyOtp() {
        guard let contact = contactNumber, let otp = otpCode else {
            onVerificationFailure?("Missing contact number or OTP")
            return
        }

        let url = APIConstants.baseURL + APIConstants.Endpoints.verifyOtp
        
        let parameters: [String: String] = [
            "number": contact,
            "otp": otp
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let token = json["token"] as? String {
                    
                    UserDefaults.standard.set(token, forKey: "authToken")
                    print("Token stored successfully: \(token)")
                    self.onVerificationSuccess?()
                    
                } else {
                    self.onVerificationFailure?("Token not found in response")
                }
            case .failure(let error):
                self.onVerificationFailure?("Network error: \(error.localizedDescription)")
            }
        }
    }
}
