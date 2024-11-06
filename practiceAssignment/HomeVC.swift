//
//  HomeVC.swift
//  practiceAssignment
//
//  Created by TGPL-MACMINI-66 on 05/11/24.
//

import UIKit
import Alamofire
import SDWebImage
import IBAnimatable

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mainImageView: AnimatableImageView!
    @IBOutlet weak var nameAgeLbl: UILabel!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    var authToken : String?
    var name: String?
    var age: Int?
    
    var likesData: [(name: String, avatar: String)] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        
        fetchNotes()
        
        bottomCollectionView.register(BottomCVC.loadNib(), forCellWithReuseIdentifier: "BottomCVC")
        
    }
        
    func fetchNotes() {
            let url = "https://app.aisle.co/V1/users/test_profile_list"
            
            // Set up headers with the authorization token
            let headers: HTTPHeaders = [
                "Authorization": "\(UserDefaults.standard.string(forKey: "authToken")!)"
            ]
            
            // Make the GET request with headers
            AF.request(url, method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let invites = json["invites"] as? [String: Any],
                       let profiles = invites["profiles"] as? [[String: Any]],
                       let profile = profiles.first,
                       let generalInfo = profile["general_information"] as? [String: Any] {
                        
                        // Extract name and age
                        self.name = generalInfo["first_name"] as? String
                        self.age = generalInfo["age"] as? Int
                        self.nameAgeLbl.text = "\(self.name!), \(self.age!)"
                        
                        // Find the first photo with "selected" = 0
                        if let photos = profile["photos"] as? [[String: Any]],
                           let targetPhoto = photos.first(where: { ($0["selected"] as? Int) == 0 }),
                           let photoUrlString = targetPhoto["photo"] as? String,
                           let photoUrl = URL(string: photoUrlString) {
                            
                            // Load the image into mainImageView
                            self.mainImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholder"))
                        }
                        
                        // Extract likes data (names and avatars)
                        if let likes = json["likes"] as? [String: Any],
                           let likeProfiles = likes["profiles"] as? [[String: Any]] {
                            for likeProfile in likeProfiles {
                                if let name = likeProfile["first_name"] as? String,
                                   let avatar = likeProfile["avatar"] as? String {
                                    self.likesData.append((name: name, avatar: avatar))
                                }
                            }
                            self.bottomCollectionView.reloadData()
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return likesData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCVC", for: indexPath) as! BottomCVC
        
        // Load image into cell's image view
        let likeData = likesData[indexPath.row]
        if let avatarUrl = URL(string: likeData.avatar) {
            cell.bottomImageView.sd_setImage(with: avatarUrl, placeholderImage: UIImage(named: "placeholder"))
        }
        // Set name label text
        cell.nameLbl.text = likeData.name
        
        return cell
    }
        
        // MARK: - Collection View Delegate Flow Layout
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate cell width for two columns with spacing
        let width = (collectionView.frame.width - 15) / 2 // Adjust 30 for spacing
        let height = width * 1.4 // Adjust the multiplier to get the desired height-to-width ratio
        return CGSize(width: width, height: height)
    }
 
}
