//
//  CustomTabBar.swift
//  CustomBottomNavBarUIKit
//
//  Created by Shafia Manzoor on 24/01/2026.
//

import UIKit

class CustomTabBar: UIView {

    // MARK: - Properties
    var buttons: [CustomTabButton] = []
    var onTabSelected: ((Int) -> Void)?

    private let tabTitles = ["Home", "Templates", "Profile"]
    private let tabIcons = ["home", "templates", "profile"]
    private let tabIconsSelected = ["homeSelected", "templatesSelected", "profileSelected"]

    var currentSelectedIndex: Int = 0
    let bumpHeight: CGFloat = 25 // Height of the upward bump

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        backgroundColor = .clear
        // Allow drawing outside bounds for the upward bump
        clipsToBounds = false

        setupButtons()
    }

    private func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for (index, title) in tabTitles.enumerated() {
            let button = CustomTabButton()
            button.configure(title: title,
                             iconName: tabIcons[index],
                             selectedIconName: tabIconsSelected[index],
                             tag: index)
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        addSubview(stackView)

        // Position buttons lower in the tab bar to make space for the upward bump
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: bumpHeight + 10), // Start below bump area
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])

        DispatchQueue.main.async {
            self.selectTab(at: 0, animated: false)
        }
    }

    // MARK: - Actions
    @objc private func tabButtonTapped(_ sender: CustomTabButton) {
        selectTab(at: sender.tag, animated: true)
        onTabSelected?(sender.tag)
    }

    func selectTab(at index: Int, animated: Bool = true) {
        guard index < buttons.count else { return }

        let previousIndex = currentSelectedIndex
        currentSelectedIndex = index

        for (i, button) in buttons.enumerated() {
            if i == index {
                // Selected button
                if animated {
                    UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                        button.setSelected(true)
                        button.transform = CGAffineTransform(translationX: 0, y: -8)
                    }
                } else {
                    button.setSelected(true)
                    button.transform = CGAffineTransform(translationX: 0, y: -8)
                }
            } else {
                // Unselected buttons
                if animated {
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                        button.setSelected(false)
                        button.transform = .identity
                    }
                } else {
                    button.setSelected(false)
                    button.transform = .identity
                }
            }
        }

        setNeedsDisplay()
    }

    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Draw the main tab bar background with rounded corners
        let backgroundRect = CGRect(x: 0, y: bumpHeight, width: rect.width, height: rect.height - bumpHeight)
        let backgroundPath = UIBezierPath(
            roundedRect: backgroundRect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 15, height: 15)
        )
        UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0).setFill()
        backgroundPath.fill()

        // Draw the wave-like bump for selected tab
        drawUltraSmoothWaveBump(in: rect)
    }

    func drawUltraSmoothWaveBump(in rect: CGRect) {
        guard buttons.count > 0, currentSelectedIndex < buttons.count else { return }

        let buttonWidth = rect.width / CGFloat(buttons.count)
        let selectedButtonCenterX = CGFloat(currentSelectedIndex) * buttonWidth + buttonWidth / 2

        let wavePath = UIBezierPath()

        let startX = selectedButtonCenterX - buttonWidth / 2
        let endX = selectedButtonCenterX + buttonWidth / 2
        let bottomY: CGFloat = bumpHeight
        let topY: CGFloat = 0

        wavePath.move(to: CGPoint(x: startX, y: bottomY))

        // Smoother control points - key is to keep them closer to the curve
        let controlOffset: CGFloat = buttonWidth * 0.28  // Reduced from 0.39
        let heightOffset: CGFloat = bumpHeight * 0.15    // Reduced from 0.4

        // Left curve - ultra smooth
        wavePath.addCurve(
            to: CGPoint(x: selectedButtonCenterX, y: topY),
            controlPoint1: CGPoint(x: startX + controlOffset, y: bottomY - heightOffset),
            controlPoint2: CGPoint(x: selectedButtonCenterX - controlOffset, y: topY + heightOffset)
        )

        // Right curve - ultra smooth
        wavePath.addCurve(
            to: CGPoint(x: endX, y: bottomY),
            controlPoint1: CGPoint(x: selectedButtonCenterX + controlOffset, y: topY + heightOffset),
            controlPoint2: CGPoint(x: endX - controlOffset, y: bottomY - heightOffset)
        )

        wavePath.close()

        // Fill
        UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0).setFill()
        wavePath.fill()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Create a separate layer for shadow that doesn't affect the bump
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: -3)
        layer.shadowRadius = 8
        layer.masksToBounds = false

        setNeedsDisplay()
    }
}
