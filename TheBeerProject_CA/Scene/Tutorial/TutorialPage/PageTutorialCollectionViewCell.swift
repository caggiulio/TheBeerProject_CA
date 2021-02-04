//
//  PageTutorialCollectionViewCell.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 04/02/21.
//

import UIKit
import Anchorage

class PageTutorialCollectionViewCell: UICollectionViewCell {
    
    var tutorialPageConfiguration: TutorialPageProtocol? {
        didSet {
            configureUI()
        }
    }
    
    var titleLabel: UILabel = UILabel(frame: .zero)
            
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
        addSubview(titleLabel)
        titleLabel.text = tutorialPageConfiguration?.titleText ?? ""
        titleLabel.textAlignment = .center
        self.contentView.backgroundColor = tutorialPageConfiguration?.backgroundColor ?? .clear
    }
    
    func setConfigurator(tutorialPageConfiguration: TutorialPageProtocol) {
        self.tutorialPageConfiguration = tutorialPageConfiguration
    }
    
    func setConstraints() {
        titleLabel.centerXAnchor == self.centerXAnchor
        titleLabel.centerYAnchor == self.centerYAnchor
        titleLabel.heightAnchor == 50
        titleLabel.widthAnchor == self.widthAnchor
    }
}
