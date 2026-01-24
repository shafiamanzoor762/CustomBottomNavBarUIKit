//
//  CustomTabBarController.swift
//  CustomBottomNavBarUIKit
//
//  Created by Shafia Manzoor on 24/01/2026.
//


import UIKit

// MARK: - Custom Tab Bar Controller
class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomTabBar()
        setupViewControllers()
    }

    private func setupCustomTabBar() {
        // Remove default tab bar
        tabBar.isHidden = true

        // Add custom tab bar with extra height for the upward bump
        let customTabBar = CustomTabBar()
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customTabBar)

        // Add extra space at the top for the upward bump
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: 100) // Increased height to accommodate bump
        ])

        // Handle tab selection
        customTabBar.onTabSelected = { [weak self] index in
            self?.selectedIndex = index
        }
    }

    private func setupViewControllers() {
        // Create your view controllers
        let homeVC = createNavController(for: CustomHomeViewController(), title: "Home")
        let templatesVC = createNavController(for: CustomTemplatesViewController(), title: "Templates")
        let profileVC = createNavController(for: CustomProfileViewController(), title: "Profile")

        viewControllers = [homeVC, templatesVC, profileVC]
        selectedIndex = 0
    }

    private func createNavController(for rootViewController: UIViewController, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.isHidden = true
        return navController
    }
}
