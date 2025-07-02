//
//  BottomCVC.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import UIKit
import IBAnimatable

class BottomCVC: UICollectionViewCell {

    @IBOutlet weak var bottomImageView: AnimatableImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomImageView.blurEffectStyle = .light
        
    }
    
    class func loadNib() -> UINib? {
        UINib(nibName: "BottomCVC", bundle: .main)
    }

}

