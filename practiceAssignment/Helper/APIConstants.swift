//
//  APIConstants.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://app.aisle.co/V1"
    
    struct Endpoints {
        
        static let phoneNumberLogin = "/users/phone_number_login"
        
        static let verifyOtp = "/users/verify_otp"
        
        static let testProfileList = "/users/test_profile_list"
        
    }
}
