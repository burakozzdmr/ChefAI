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
            with: "Home",
            and: .init(systemName: "house.fill") ?? .init(),
            for: HomepageViewController()
        )
        let mealsVC = createNav(
            with: "Search",
            and: .init(systemName: "magnifyingglass") ?? .init(),
            for: TabSearchViewController()
        )
        let ingredientVC = createNav(
            with: "Ingredients",
            and: .init(systemName: "cart.fill") ?? .init(),
            for: IngredientViewController()
        )
        let favouriteVC = createNav(
            with: "Favourites",
            and: .init(systemName: "heart.fill") ?? .init(),
            for: FavouriteViewController()
        )
        let profileVC = createNav(
            with: "Profile",
            and: .init(systemName: "person.fill") ?? .init(),
            for: ProfileViewController()
        )
        
        self.setViewControllers([homepageVC, mealsVC, ingredientVC, favouriteVC, profileVC], animated: false)
        
        self.tabBar.backgroundColor = .customBackgroundColor2
        self.tabBar.tintColor = .customButton
        self.tabBar.unselectedItemTintColor = .lightGray
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .customBackgroundColor2

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    func createNav(with title: String, and image: UIImage, for controller: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        navigationItem.hidesBackButton = true
        navigationItem.style = .editor
        
        return navController
    }
}
