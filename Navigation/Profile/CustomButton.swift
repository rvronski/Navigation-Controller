//
//  Button.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.11.2022.
//

import UIKit

class CustomButton: UIButton {
    var tapButton: ( () -> Void )?
    init(buttonText: String, textColor: UIColor, background: UIColor, frame: CGRect) {
        super.init(frame: .zero )
        setTitle(buttonText, for: .normal)
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        setTitle("Push", for: .normal)
        backgroundColor = background
        setTitleColor(textColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton() {
        tapButton?()
    }
    
}
