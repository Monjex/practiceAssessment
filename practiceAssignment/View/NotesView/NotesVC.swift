//
//  HomeVC.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import UIKit
import Alamofire
import SDWebImage
import IBAnimatable

class NotesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var mainImageView: AnimatableImageView!
    @IBOutlet weak var nameAgeLbl: UILabel!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
 
    let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.register(BottomCVC.loadNib(), forCellWithReuseIdentifier: "BottomCVC")
        
        bindViewModel()
        viewModel.fetchUserProfile()
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let name = self.viewModel.name, let age = self.viewModel.age {
                    self.nameAgeLbl.text = "\(name), \(age)"
                }
                
                if let urlString = self.viewModel.mainImageURL,
                   let url = URL(string: urlString) {
                    self.mainImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
                }
                
                self.bottomCollectionView.reloadData()
            }
        }

        viewModel.onError = { errorMessage in
            print("Fetch error: \(errorMessage)")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.likesData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BottomCVC", for: indexPath) as! BottomCVC
        let like = viewModel.likesData[indexPath.row]
        cell.nameLbl.text = like.name
        if let url = URL(string: like.avatar) {
            cell.bottomImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 15) / 2
        return CGSize(width: width, height: width * 1.4)
    }
    
}
