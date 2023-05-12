//
//  Button.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 11.05.2023.
//
import UIKit

class CustomButton: UIButton {
    var tapButton: ( () -> Void )?
    init(buttonText: String, textColor: UIColor, background: UIColor?, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero )
        setTitle(buttonText, for: .normal)
        backgroundColor = background ?? .clear
        layer.cornerRadius = 20
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
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
