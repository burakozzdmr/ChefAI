//
//  TabBarController.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import UIKit

// MARK: - TabBarController

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
}

// MARK: - Privates

private extension TabBarController {
    func configureTabBar() {
        let homepageVC = createNav(
            with: "Anasayfa",
            and: .init(systemName: "house") ?? .init(),
            for: HomepageViewController()
        )
        let mealsVC = createNav(
            with: "Yemekler",
            and: .init(systemName: "fork.knife") ?? .init(),
            for: MealsViewController()
        )
        let cartVC = createNav(
            with: "Sepet",
            and: .init(systemName: "cart.fill") ?? .init(),
            for: CartViewController()
        )
        let profileVC = createNav(
            with: "Profil",
            and: .init(systemName: "person.fill") ?? .init(),
            for: ProfileViewController()
        )
        
        self.setViewControllers([homepageVC, mealsVC, cartVC, profileVC], animated: false)
        
        self.tabBar.backgroundColor = .customBackgroundColor2
        self.tabBar.tintColor = .customButton
        self.tabBar.unselectedItemTintColor = .lightGray
    }
    
    func createNav(with title: String, and image: UIImage, for controller: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
