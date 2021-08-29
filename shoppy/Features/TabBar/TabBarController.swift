//
//  TabBarController.swift
//  shoppy
//
//  Created by YasirRomaya on 8/22/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarStyle()
        setTabBarViewControllers()
    }
    
    func setTabBarStyle(){
        tabBar.isTranslucent = false
        tabBar.barStyle = .default
        tabBar.tintColor = UIColor(named: "AccentColor")
        tabBar.backgroundColor = Style.sharedInstance.getNavBarBackgroundColor()
    }
    
    func setTabBarViewControllers(){
        /// init tab bar view controllers
        var tabBarViewControllers = [UIViewController]()
        
        /// create home view controller
        let homeViewController = HomeViewController(style: .grouped)
        
        /// create home view  icon & title
        var homeVCIcon:UIImage!
        
        if #available(iOS 13.0, *) {
            homeVCIcon = UIImage(systemName: "safari")!
        } else {
            homeVCIcon = UIImage(named: "ic_compass")!
        }
        
        let homeTitle = "Discover"
        
        /// create home navigation controller
        let  homeNavigationController = UINavigationController(rootViewController: homeViewController)
        
        /// set home navigation controller style
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Style.sharedInstance.getFontColor()]
            navBarAppearance.titleTextAttributes = [.foregroundColor: Style.sharedInstance.getFontColor()]
            navBarAppearance.backgroundColor = Style.sharedInstance.getNavBarBackgroundColor()
            
            homeNavigationController.navigationBar.standardAppearance = navBarAppearance
            homeNavigationController.navigationBar.compactAppearance = navBarAppearance
            homeNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            homeNavigationController.navigationBar.prefersLargeTitles = true
            homeNavigationController.navigationBar.isTranslucent = false
            homeNavigationController.navigationBar.tintColor = Style.sharedInstance.getAccentColor()
            
        }else{
            homeNavigationController.navigationBar.isTranslucent = false
            homeNavigationController.navigationBar.tintColor = Style.sharedInstance.getAccentColor()
            homeNavigationController.navigationBar.prefersLargeTitles = true
            homeNavigationController.navigationBar.barTintColor = Style.sharedInstance.getNavBarBackgroundColor()
        }
        
        
        /// set home navigation controller tab bar item
        homeNavigationController.tabBarItem = createTabBarItem(tabBarItemImage: homeVCIcon, tabBarItemTitle: homeTitle)
        
        /// set home navigation controller view title
        homeViewController.title = homeTitle
        
        /// add first view for tab bar view controllers array
        tabBarViewControllers.append(homeNavigationController)
        
        /// set view controllers array to tab bar view controllers
        self.viewControllers = tabBarViewControllers
    }
    
    func createTabBarItem(tabBarItemImage: UIImage, tabBarItemTitle:String) -> UITabBarItem{
        let tabBarItem = UITabBarItem()
        tabBarItem.image = tabBarItemImage
        tabBarItem.title = tabBarItemTitle
        return tabBarItem
    }
    
    
    
}
