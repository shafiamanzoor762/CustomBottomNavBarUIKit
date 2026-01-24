//
//  InnerCurvedTabBarController.swift
//  CustomBottomNavBarUIKit
//
//  Created by Shafia Manzoor on 24/01/2026.
//

import UIKit

class InnerCurvedTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        setupViewControllers()
    }

    private func setupCustomTabBar() {
        // Remove default tab bar
        tabBar.isHidden = true

        // Add custom tab bar
        let customTabBar = InnerCurvedTabBar()
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 90)
        ])

        // Handle tab selection
        customTabBar.onTabSelected = { [weak self] index in
            self?.selectedIndex = index
        }
    }

    private func setupViewControllers() {
        // Create your view controllers
        let homeVC = createNavController(for: HomeViewController(), title: "Home")
        let templatesVC = createNavController(for: TemplatesViewController(), title: "Templates")
        let profileVC = createNavController(for: ProfileViewController(), title: "Profile")

        viewControllers = [homeVC, templatesVC, profileVC]
        selectedIndex = 0
    }

    private func createNavController(for rootViewController: UIViewController, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.isHidden = true
        return navController
    }
}
