//
//  InnerCurvedTabButton.swift
//  CustomBottomNavBarUIKit
//
//  Created by Shafia Manzoor on 24/01/2026.
//

import UIKit

class InnerCurvedTabButton: UIControl {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    private var normalIconName: String = ""
    private var filledIconName: String = ""
    
    private var imageViewHeightConstraint: NSLayoutConstraint?
    private var imageViewWidthConstraint: NSLayoutConstraint?

    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Configure stack view
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        // Configure image view
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(imageView)

        // Configure title label
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.textAlignment = .center
        stackView.addArrangedSubview(titleLabel)

        // Set constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Create height and width constraints for image view with default values
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 24)
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 24)
        
        imageViewHeightConstraint?.isActive = true
        imageViewWidthConstraint?.isActive = true

        // Initial appearance
        updateAppearance()
    }

    func configure(title: String, iconName: String, iconNameFilled: String, tag: Int) {
        self.tag = tag
        self.normalIconName = iconName
        self.filledIconName = iconNameFilled
        titleLabel.text = title
        
        updateIconImage()
    }

    func setSelected(_ selected: Bool) {
        isSelected = selected
    }

    private func updateIconImage() {
        let iconName = isSelected ? filledIconName : normalIconName
        let pointSize: CGFloat = isSelected ? 28 : 24
        
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .medium, scale: .default)
        let iconImage = UIImage(systemName: iconName, withConfiguration: configuration)
        imageView.image = iconImage
        
        // Update image view size constraints
        imageViewHeightConstraint?.constant = pointSize
        imageViewWidthConstraint?.constant = pointSize
    }

    private func updateAppearance() {
        if isSelected {
            imageView.tintColor = UIColor.purple
            titleLabel.textColor = UIColor.clear
        } else {
            imageView.tintColor = .gray
            titleLabel.textColor = .gray
        }
        
        updateIconImage()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.7
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
        sendActions(for: .touchUpInside)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
}
