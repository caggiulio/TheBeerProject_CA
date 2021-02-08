//
//  CustomSegmentedControl.swift
//  TheBeerProject_CA
//
//  Created by Nunzio Giulio Caggegi on 07/02/21.
//

import UIKit
import Anchorage

class CustomSegmentedControl: UIView {
    
    var segmentedControl: UISegmentedControl = {
        var segControl = UISegmentedControl(frame: .zero)
        segControl.backgroundColor = .clear
        segControl.selectedSegmentTintColor = .clear
        return segControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) isn't supported")
    }
    
    func configureUI() {
        self.addSubview(segmentedControl)
    }
    
    func configureConstraints() {
        segmentedControl.topAnchor == self.topAnchor
        segmentedControl.leadingAnchor == self.leadingAnchor
        segmentedControl.trailingAnchor == self.trailingAnchor
        segmentedControl.bottomAnchor == self.bottomAnchor
    }
}
