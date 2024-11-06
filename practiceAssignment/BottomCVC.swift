//
//  BottomCVC.swift
//  practiceAssignment
//
//  Created by TGPL-MACMINI-66 on 06/11/24.
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

