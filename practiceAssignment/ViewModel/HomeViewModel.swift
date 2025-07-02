//
//  HomeViewModel.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import Foundation
import Alamofire

class HomeViewModel {
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    var name: String?
    var age: Int?
    var mainImageURL: String?
    
    var likesData: [(name: String, avatar: String)] = []
    
    func fetchUserProfile() {
        let url = APIConstants.baseURL + APIConstants.Endpoints.testProfileList
        
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            onError?("Missing auth token")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        AF.request(url, headers: headers).responseDecodable(of: UserProfileResponse.self) { response in
            switch response.result {
            case .success(let data):
                if let profile = data.invites.profiles.first {
                    self.name = profile.general_information.first_name
                    self.age = profile.general_information.age
                    
                    if let selectedPhoto = profile.photos.first(where: { $0.selected == false }) {
                        self.mainImageURL = selectedPhoto.photo
                    }
                }
                
                self.likesData = data.likes.profiles.map {
                    ($0.first_name, $0.avatar)
                }
                
                self.onDataUpdated?()
                
            case .failure(let error):
                self.onError?("Failed to fetch: \(error.localizedDescription)")
            }
        }
        
    }
}
