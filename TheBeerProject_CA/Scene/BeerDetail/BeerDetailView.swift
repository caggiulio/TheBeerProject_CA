//
//  BeerDetailView.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 02/02/21.
//

import Foundation
import UIKit
import Anchorage

class BeerDetailView: UIView {
    // MARK: View
    var containerView: UIView = UIView(frame: .zero)
    var infoStackView: UIStackView = UIStackView(frame: .zero)
    
    var beerDescr: UILabel = UILabel(frame: .zero)
    var beerTitle: UILabel = UILabel(frame: .zero)
    var beerSubtitle: UILabel = UILabel(frame: .zero)
    var beerImage: UIImageView = UIImageView(frame: .zero)
    var transparentView: UIView = UIView(frame: .zero)
    var closeButton: UIButton = UIButton(frame: .zero)
    
    var closeButtonDidTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }
    
    func configureUI() {
        backgroundColor = UIColor(white: 0, alpha: 0.8)
        addSubview(transparentView)
        addSubview(containerView)
        addSubview(beerDescr)
        addSubview(beerTitle)
        addSubview(beerSubtitle)
        addSubview(beerImage)
        addSubview(infoStackView)
        addSubview(closeButton)
        
        transparentView.backgroundColor = UIColor(white: 0, alpha: 0.65)
        containerView.backgroundColor = UIColor(named: "AppMainColor")
        beerImage.contentMode = .scaleAspectFit
        
        beerTitle.font = UIFont.boldSystemFont(ofSize: 22)
        beerSubtitle.font = UIFont.boldSystemFont(ofSize: 17)
        beerDescr.font = UIFont.boldSystemFont(ofSize: 15)
        beerTitle.textColor = .white
        beerSubtitle.textColor = .gray
        beerDescr.textColor = .gray
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
    }
    
    func configureConstraints() {
        //TRANSPARENTVIEW
        
        transparentView.bottomAnchor == bottomAnchor
        transparentView.topAnchor == topAnchor
        transparentView.leadingAnchor == leadingAnchor
        transparentView.trailingAnchor == trailingAnchor
        
        //CLOSE BUTTON
        closeButton.topAnchor == transparentView.topAnchor + 50
        closeButton.trailingAnchor == transparentView.trailingAnchor - 20
        
        //CONTAINER VIEW
        containerView.bottomAnchor == transparentView.bottomAnchor
        containerView.leadingAnchor == transparentView.leadingAnchor
        containerView.trailingAnchor == transparentView.trailingAnchor
        containerView.heightAnchor == 300
        
        //IMAGE VIEW
        beerImage.topAnchor == containerView.topAnchor + 15
        beerImage.heightAnchor == 230
        beerImage.leadingAnchor == containerView.leadingAnchor + 15
        beerImage.widthAnchor == 150
        
        //STACKVIEW
        infoStackView.topAnchor == beerImage.topAnchor
        infoStackView.heightAnchor == beerImage.heightAnchor
        infoStackView.leadingAnchor == beerImage.trailingAnchor + 10
        infoStackView.trailingAnchor == containerView.trailingAnchor - 10
        infoStackView.axis = .vertical
        infoStackView.alignment = .fill
        infoStackView.distribution = .fillProportionally
        infoStackView.spacing = 5
        
        beerDescr.numberOfLines = 0
        beerDescr.minimumScaleFactor = 0.25
        beerDescr.adjustsFontSizeToFitWidth = true
        
        infoStackView.addArrangedSubview(beerTitle)
        infoStackView.addArrangedSubview(beerSubtitle)
        infoStackView.addArrangedSubview(beerDescr)
        
        beerTitle.heightAnchor == 30
        beerSubtitle.heightAnchor == 30
    }
    
    func updateView(beer: Beer?) {
        beerImage.sd_setImage(with: URL(string: (beer?.image_url)!))
        beerTitle.text = beer?.name
        beerSubtitle.text = beer?.tagline
        beerDescr.text = beer?.description
    }
    
    @objc func closeAction(_ sender: Any) {
        closeButtonDidTap?()
    }
}
