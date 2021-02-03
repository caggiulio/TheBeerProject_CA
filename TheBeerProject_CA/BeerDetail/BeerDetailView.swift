//
//  BeerDetailView.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 02/02/21.
//

import Foundation
import UIKit
import Anchorage

extension BeerDetailViewController {
    func configureUI() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        self.view.addSubview(transparentView)
        self.view.addSubview(containerView)
        self.view.addSubview(beerDescr)
        self.view.addSubview(beerTitle)
        self.view.addSubview(beerSubtitle)
        self.view.addSubview(beerImage)
        self.view.addSubview(infoStackView)
        self.view.addSubview(closeButton)
        
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
    
    func setConstraints() {
        //TRANSPARENTVIEW
        
        transparentView.bottomAnchor == self.view.bottomAnchor
        transparentView.topAnchor == self.view.topAnchor
        transparentView.leadingAnchor == self.view.leadingAnchor
        transparentView.trailingAnchor == self.view.trailingAnchor
        
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
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateView(beer: Beer?) {
        beerImage.sd_setImage(with: URL(string: (beer?.image_url)!))
        beerTitle.text = beer?.name
        beerSubtitle.text = beer?.tagline
        beerDescr.text = beer?.description
    }
}
