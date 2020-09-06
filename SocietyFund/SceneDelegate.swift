//
//  SceneDelegate.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import MMDrawerController
import SlideMenuControllerSwift
import MaterialComponents.MaterialNavigationDrawer
import FBSDKCoreKit
import GoogleSignIn

var mmDrawerContainer: MMDrawerController?
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)

        if let isLoggedIn = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool, isLoggedIn == true {
            // instantiate the main tab bar controller and set it as root view controller
            // using the storyboard identifier we set earlier
//            let tabController = storyboard.instantiateViewController(identifier: "TabBarController") as! TabBarController
//            let menuController = storyboard.instantiateViewController(identifier: "MenuViewController") as! MenuViewController
//            mmDrawerContainer = MMDrawerController(center: tabController, leftDrawerViewController: UINavigationController(rootViewController: menuController))
//            mmDrawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
//            mmDrawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
//            mmDrawerContainer?.modalPresentationStyle = .fullScreen
//            setRootViewController(rootViewController: mmDrawerContainer!)
        } else {
            // if user isn't logged in
            // instantiate the navigation controller and set it as root view controller
            // using the storyboard identifier we set earlier
            let tabController = storyboard.instantiateViewController(identifier: "TabBarController") as! TabBarController
            let menuController = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
            mmDrawerContainer = MMDrawerController(center: tabController, leftDrawerViewController: menuController)
            mmDrawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
            mmDrawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
            mmDrawerContainer?.setDrawerVisualStateBlock(MMDrawerVisualState.swingingDoorVisualStateBlock())
            MMDrawerVisualState.slideAndScaleBlock()
            mmDrawerContainer?.bouncePreview(for: .left, completion:  nil)
            mmDrawerContainer?.shouldStretchDrawer = false
            mmDrawerContainer?.modalPresentationStyle = .fullScreen
            setRootViewController(rootViewController: mmDrawerContainer!)
            Log.debug(msg: "showing dashboard")
        }
    }
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func setRootViewController(rootViewController:UIViewController) {
       
        // add animation
//        UIView.transition(with: window,
//                          duration: 0.5,
//                          options: [.transitionFlipFromLeft],
//                          animations: nil,
//                          completion: nil)
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }

    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        Log.debug(msg: "check for expiration of token")
        if let token = AccessToken.current,
            !token.isExpired {
            Log.debug(msg: "fbtoken: \(token) logged in")
        }else if let current = GIDSignIn.sharedInstance()?.currentUser, (current.authentication.accessToken != nil) {
            Log.debug(msg: "googletoken: \(current) logged in")
        }else {
            Log.debug(msg: "logged out")
        }
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

