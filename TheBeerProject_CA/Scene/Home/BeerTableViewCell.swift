//
//  BeerTableViewCell.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit
import Anchorage
import SDWebImage

class BeerCollectionViewCell: UICollectionViewCell {
    var beerSubtitle: UILabel = UILabel(frame: .zero)
    var beerDescr: UILabel = UILabel(frame: .zero)
    var beerTitle: UILabel = UILabel(frame: .zero)
    var beerImage: UIImageView = UIImageView(frame: .zero)
    var stackView: UIStackView = UIStackView(frame: .zero)
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.contentView.addSubview(beerImage)
        self.contentView.addSubview(stackView)
        
        self.contentView.backgroundColor = UIColor(named: "AppMainColor")
        beerTitle.font = UIFont.boldSystemFont(ofSize: 22)
        beerSubtitle.font = UIFont.boldSystemFont(ofSize: 17)
        beerDescr.font = UIFont.boldSystemFont(ofSize: 15)
        beerTitle.textColor = .white
        beerSubtitle.textColor = .gray
        beerDescr.textColor = .gray
    }
    
    func setConstraints() {
        //IMAGE
        
        beerImage.topAnchor == self.contentView.topAnchor + 20
        beerImage.bottomAnchor == self.contentView.bottomAnchor - 20
        beerImage.leadingAnchor == self.contentView.leadingAnchor + 15
        beerImage.widthAnchor == 140
        beerImage.contentMode = .scaleAspectFit
        
        //STACKVIEW WITH INFO
        stackView.topAnchor == beerImage.topAnchor
        stackView.heightAnchor == beerImage.heightAnchor
        stackView.leadingAnchor == beerImage.trailingAnchor + 10
        stackView.trailingAnchor == self.contentView.trailingAnchor - 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        beerDescr.numberOfLines = 0
        beerDescr.minimumScaleFactor = 0.65
        
        stackView.addArrangedSubview(beerTitle)
        stackView.addArrangedSubview(beerSubtitle)
        stackView.addArrangedSubview(beerDescr)
        
        beerTitle.heightAnchor == 30
        beerSubtitle.heightAnchor == 30
    }
    
    func updateUI(beer: Beer) {
        beerImage.sd_setImage(with: URL(string: beer.image_url ?? ""))
        beerTitle.text = beer.name
        beerSubtitle.text = beer.tagline
        beerDescr.text = beer.description
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct BeerCollectionViewCell_Pr: PreviewProvider {
    
    static var previews: some View {
        BeerCollectionViewCell().makePreview().previewLayout(.fixed(width: 414, height: 230))
    }
}
#endif
