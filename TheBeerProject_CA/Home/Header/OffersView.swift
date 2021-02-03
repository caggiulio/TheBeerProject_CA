//
//  OffersView.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 03/02/21.
//

import UIKit

class OffersView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }
    
    func configureUI() {
        self.backgroundColor = UIColor(named: "Gold")
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
}
