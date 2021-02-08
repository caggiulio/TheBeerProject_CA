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
    
    var segmentedControl: CustomSegmentedControl = {
        var segControl = CustomSegmentedControl(frame: .zero)
        segControl.segmentedControl.insertSegment(withTitle: "TestSegControl_0", at: 0, animated: false)
        segControl.segmentedControl.insertSegment(withTitle: "TestSegControl_1", at: 1, animated: false)
        segControl.segmentedControl.insertSegment(withTitle: "TestSegControl_2", at: 2, animated: false)
        return segControl
    }()
    
    var bottomView: UIView = {
        var bView = UIView(frame: .zero)
        bView.backgroundColor = .white
        bView.clipsToBounds = true
        return bView
    }()
    
    var nextButtonDidTap: (() -> Void)?
    var segmentedControlDidTap: ((Int) -> Void)?
            
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
        segmentedControl.addSubview(bottomView)
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        segmentedControl.segmentedControl.addTarget(self, action: #selector(setSegmentedControlActions), for: .valueChanged)
        
        addSubview(titleLabel)
        addSubview(segmentedControl)
                
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
        
        segmentedControl.topAnchor == titleLabel.topAnchor + 50
        segmentedControl.centerXAnchor == self.centerXAnchor
        segmentedControl.widthAnchor == UIScreen.main.bounds.width - 20
        segmentedControl.heightAnchor == 50
        
        bottomView.bottomAnchor == segmentedControl.bottomAnchor
        bottomView.leadingAnchor == segmentedControl.leadingAnchor
        bottomView.widthAnchor == (segmentedControl.widthAnchor / Double(segmentedControl.segmentedControl.numberOfSegments))
        bottomView.heightAnchor == 5
    }
    
    @objc func setSegmentedControlActions(_ sender: UISegmentedControl) {
        segmentedControlDidTap?(sender.selectedSegmentIndex)
        
        bottomView.removeConstraints(bottomView.constraints)
        
        bottomView.bottomAnchor == segmentedControl.bottomAnchor
        bottomView.widthAnchor == (segmentedControl.widthAnchor / Double(segmentedControl.segmentedControl.numberOfSegments))
        bottomView.heightAnchor == 5
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            let finalOrigin = (self.segmentedControl.bounds.width / CGFloat(self.segmentedControl.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.segmentedControl.selectedSegmentIndex)
            self.bottomView.frame.origin.x = finalOrigin
        } completion: { (finished) in
            
        }
    }
    
    @objc func nextAction(_ sender: Any) {
        nextButtonDidTap?()
    }
}
