//
//  ContactViewModel.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import Foundation
import Alamofire

class ContactViewModel {
    
    var phoneNumber: String?
    
    // Closure for callback to ViewController
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    func applyContact() {
        let url = APIConstants.baseURL + APIConstants.Endpoints.phoneNumberLogin
        let parameters: [String: String] = ["number": phoneNumber!]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any],
                   let status = json["status"] as? Int {
                    
                    if status == 1 {
                        self.onLoginSuccess?()
                    } else {
                        self.onLoginFailure?("Login failed with status: \(status)")
                    }
                } else {
                    self.onLoginFailure?("Unexpected response format")
                }
            case .failure(let error):
                self.onLoginFailure?("Error: \(error.localizedDescription)")
            }
        }     
    }
}
