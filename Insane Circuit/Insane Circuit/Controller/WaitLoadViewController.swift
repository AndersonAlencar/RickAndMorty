//
//  WaitLoadViewController.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 08/02/21.
//  Copyright © 2021 Anderson Alencar. All rights reserved.
//

import UIKit
import Lottie

class WaitLoadViewController: UIViewController {
    
    private var animationView: AnimationView?
    let tabBar = MainTabBarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = AnimationView(name: "galaxy")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        
        animationView?.animationSpeed = 0.3
        view.addSubview(animationView!)
        animationView?.backgroundColor = .backgroundBlueColor
        animationView?.play()
        animationView?.loopMode = .loop
        initTab()
    }
    
    func initTab() {
        let controller = tabBar.viewControllers?.first as! UINavigationController
        let discover = controller.topViewController as! DiscoverViewController
        discover.waitLoadReference = self
        discover.viewDidLoad()
    }
    
    func presentDiscoverController() {
        DispatchQueue.main.async { [self] in
            guard let window = UIApplication.shared.windows.first else { return }
            window.rootViewController = tabBar
            UIView.transition(
                with: window,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: nil,
                completion: nil)
        }
    }

}
