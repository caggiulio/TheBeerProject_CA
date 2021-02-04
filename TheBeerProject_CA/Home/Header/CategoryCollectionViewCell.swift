//
//  CategoryCollectionViewCell.swift
//  TheBeerProject
//
//  Created by Nunzio Giulio Caggegi on 20/08/2019.
//  Copyright © 2019 Nunzio Giulio Caggegi. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    var containerCategoryCell: UIView = UIView(frame: .zero)
    var categoryName: UILabel = UILabel(frame: .zero)
    
    // Property
    var shouldToSelect: Bool = false {
        didSet {
            if shouldToSelect {
                containerCategoryCell.backgroundColor = UIColor.init(named: "Gold")
            } else {
                containerCategoryCell.backgroundColor = .darkGray
            }
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configureUI() {
        self.contentView.addSubview(containerCategoryCell)
        self.contentView.addSubview(categoryName)
        
        containerCategoryCell.clipsToBounds = true
        containerCategoryCell.layer.cornerRadius = 20
        containerCategoryCell.backgroundColor = .darkGray
        categoryName.textAlignment = .center
        categoryName.font = .boldSystemFont(ofSize: 17)
    }
    
    func setConstraints() {
        containerCategoryCell.translatesAutoresizingMaskIntoConstraints = false
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        
        containerCategoryCell.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2).isActive = true
        containerCategoryCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2).isActive = true
        containerCategoryCell.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 2).isActive = true
        containerCategoryCell.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2).isActive = true
        
        categoryName.topAnchor.constraint(equalTo: containerCategoryCell.topAnchor).isActive = true
        categoryName.bottomAnchor.constraint(equalTo: containerCategoryCell.bottomAnchor).isActive = true
        categoryName.leadingAnchor.constraint(equalTo: containerCategoryCell.leadingAnchor).isActive = true
        categoryName.trailingAnchor.constraint(equalTo: containerCategoryCell.trailingAnchor).isActive = true
    }
    
    func updateUI(category: Category) {
        self.categoryName.text = category.category
        self.shouldToSelect = category.shouldSelect
    }
}
