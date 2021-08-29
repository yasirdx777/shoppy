//
//  SceneDelegate.swift
//  shoppy
//
//  Created by YasirRomaya on 8/22/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        initWindow(windowScene: windowScene)
        setWindowFirstView()
    }
    
    
    @available(iOS 13.0, *)
    func initWindow(windowScene: UIWindowScene){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene
    }
    
    func setWindowFirstView(){
        let tabBar = TabBarController()
        self.window?.rootViewController = tabBar
        self.window?.makeKeyAndVisible()
    }
    
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

