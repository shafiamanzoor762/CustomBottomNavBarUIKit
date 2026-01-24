//
//  InnerCurvedTabBar.swift
//  CustomBottomNavBarUIKit
//
//  Created by Shafia Manzoor on 24/01/2026.
//

import UIKit

class InnerCurvedTabBar: UIView {

    // MARK: - Properties
    var buttons: [InnerCurvedTabButton] = []
    var onTabSelected: ((Int) -> Void)?

    private let tabTitles = ["Home", "Templates", "Profile"]
    private let tabIcons = ["house", "square.grid.2x2", "person"]
    private let tabIconsFilled = ["house.fill", "square.grid.2x2.fill", "person.fill"]

    var currentSelectedIndex: Int = 0
    let bumpHeight: CGFloat = 38

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
        setupButtons()
        selectTab(at: 0, animated: false)
    }

    private func setupButtons() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for index in 0..<tabTitles.count {
            let button = InnerCurvedTabButton()
            button.configure(title: tabTitles[index], iconName: tabIcons[index], iconNameFilled: tabIconsFilled[index], tag: index)
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }

    // MARK: - Actions
    @objc private func tabButtonTapped(_ sender: InnerCurvedTabButton) {
        selectTab(at: sender.tag, animated: true)
        onTabSelected?(sender.tag)
    }

    func selectTab(at index: Int, animated: Bool = true) {
        guard index < buttons.count else { return }

        let previousIndex = currentSelectedIndex
        currentSelectedIndex = index

        if previousIndex != index {
            if animated {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                    self.buttons[previousIndex].setSelected(false)
                    self.buttons[previousIndex].transform = .identity
                }

                UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
                    self.buttons[index].setSelected(true)
                    self.buttons[index].transform = CGAffineTransform(translationX: 0, y: -8)
                }

            } else {
                buttons[previousIndex].setSelected(false)
                buttons[previousIndex].transform = .identity

                buttons[index].setSelected(true)
                buttons[index].transform = CGAffineTransform(translationX: 0, y: -8)
            }
        } else {
            // Initial setup - make sure selected button is properly styled and transformed
            buttons[index].setSelected(true)
            buttons[index].transform = CGAffineTransform(translationX: 0, y: -8)
        }

        setNeedsDisplay()
    }

    // MARK: - Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let backgroundPath = UIBezierPath(rect: rect)
        UIColor(red: 255/255, green: 219/255, blue: 220/255, alpha: 1.0).setFill()
        backgroundPath.fill()

        // Draw the upward bump for selected tab
        drawUpwardBumpForSelectedTab(in: rect)

        // Add top border (at the TOP of the tab bar)
        let borderPath = UIBezierPath()
        borderPath.move(to: CGPoint(x: 0, y: 0))
        borderPath.addLine(to: CGPoint(x: rect.width, y: 0))
        UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).setStroke()
        borderPath.lineWidth = 0.5
        borderPath.stroke()
    }

    func drawUpwardBumpForSelectedTab(in rect: CGRect) {
        guard buttons.count > 0, currentSelectedIndex < buttons.count else { return }

        let buttonWidth = rect.width / CGFloat(buttons.count)
        let selectedButtonCenterX = CGFloat(currentSelectedIndex) * buttonWidth + buttonWidth / 2

        let bumpPath = UIBezierPath()
        let topY: CGFloat = 0
        let bottomY = bumpHeight

        let startX = selectedButtonCenterX - buttonWidth / 2
        let endX = selectedButtonCenterX + buttonWidth / 2

        // Move to starting point (left side of selected tab)
        bumpPath.move(to: CGPoint(x: startX, y: topY))

        // Curve downward to create the bump
        bumpPath.addCurve(
            to: CGPoint(x: selectedButtonCenterX, y: bottomY),
            controlPoint1: CGPoint(x: startX + buttonWidth / 4, y: topY),
            controlPoint2: CGPoint(x: selectedButtonCenterX - buttonWidth / 8, y: bottomY)
        )

        // Curve back up to complete the bump
        bumpPath.addCurve(
            to: CGPoint(x: endX, y: topY),
            controlPoint1: CGPoint(x: selectedButtonCenterX + buttonWidth / 8, y: bottomY),
            controlPoint2: CGPoint(x: endX - buttonWidth / 4, y: topY)
        )

        // Close the path back to start
        bumpPath.addLine(to: CGPoint(x: startX, y: topY))
        bumpPath.close()

        // Fill the bump with white
        UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0).setFill()
        bumpPath.fill()

        // Add a subtle outline to the bump
        UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.5).setStroke()
        bumpPath.lineWidth = 1.0
        bumpPath.stroke()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
}
