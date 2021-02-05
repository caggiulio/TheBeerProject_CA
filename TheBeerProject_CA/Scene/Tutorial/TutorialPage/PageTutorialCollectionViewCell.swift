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
            setConstraints()
        }
    }
    
    var titleLabel: UILabel = UILabel(frame: .zero)
    var nextButton: UIButton = {
        var nextButton = UIButton(frame: .zero)
        nextButton.setTitle("NEXT", for: .normal)
        return nextButton
    }()
    
    var nextButtonDidTap: (() -> Void)?
            
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
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        addSubview(titleLabel)
        
        if tutorialPageConfiguration?.hasNextButton ?? false {
            addSubview(nextButton)
        } else {
            nextButton.removeFromSuperview()
        }
        
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
        
        if tutorialPageConfiguration?.hasNextButton ?? false {
            nextButton.topAnchor == self.topAnchor + 20
            nextButton.trailingAnchor == self.trailingAnchor - 20
            nextButton.heightAnchor == 50
        }
    }
    
    @objc func nextAction(_ sender: Any) {
        nextButtonDidTap?()
    }
}
