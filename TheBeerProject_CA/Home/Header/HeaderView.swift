//
//  HeaderView.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 03/02/21.
//

import UIKit
import Anchorage

class HeaderView: UICollectionReusableView {
    
    var offersView: OffersView = OffersView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }
    
    func configureUI() {
        self.addSubview(offersView)
        self.backgroundColor = UIColor(named: "AppMainColor")
    }
    
    func configureConstraints() {
        offersView.topAnchor == self.topAnchor
        offersView.leadingAnchor == self.leadingAnchor + 10
        offersView.trailingAnchor == self.trailingAnchor - 10
        offersView.bottomAnchor == self.bottomAnchor
    }
}

extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = .red
        cell.categoryName.text = "ciao"
        
        return cell
    }
    
}
