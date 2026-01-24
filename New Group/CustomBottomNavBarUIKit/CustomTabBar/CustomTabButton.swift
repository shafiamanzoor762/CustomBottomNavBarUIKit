//
//  CustomTabButton.swift
//  CustomBottomNavBarUIKit
//
//  Created by Shafia Manzoor on 24/01/2026.
//

import UIKit

class CustomTabButton: UIButton {

    private var selectedIcon: UIImage?
    private var unselectedIcon: UIImage?

    private let iconView = UIImageView()
    private let titleLabelCustom = UILabel()

    private let iconSize: CGFloat = 26

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false

        // Icon
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .darkGray
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)

        // Title
        titleLabelCustom.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabelCustom.textColor = .darkGray
        titleLabelCustom.textAlignment = .center
        titleLabelCustom.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabelCustom)

        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.widthAnchor.constraint(equalToConstant: iconSize),
            iconView.heightAnchor.constraint(equalToConstant: iconSize),

            titleLabelCustom.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6),
            titleLabelCustom.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func configure(title: String, iconName: String, selectedIconName: String, tag: Int) {
        self.tag = tag
        self.unselectedIcon = UIImage(named: iconName)
        self.selectedIcon = UIImage(named: selectedIconName)
        self.titleLabelCustom.text = title
        iconView.image = unselectedIcon
        
    }

    func setSelected(_ isSelected: Bool) {
        if isSelected {
            iconView.image = selectedIcon
            titleLabelCustom.textColor = UIColor(red: 0.82, green: 0.24, blue: 0.24, alpha: 1.0)

            // Animate icon scale up — increased to 1.55x
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.iconView.transform = CGAffineTransform(scaleX: 1.55, y: 1.55)
                self.titleLabelCustom.textColor = .red
            }
        } else {
            iconView.image = unselectedIcon
            titleLabelCustom.textColor = .darkGray

            // Reset scale
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.iconView.transform = .identity
            }
        }
    }


}
