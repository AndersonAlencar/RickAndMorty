//
//  WailoadViewModel.swift
//  Insane Circuit
//
//  Created by Anderson Alencar on 11/02/21.
//  Copyright © 2021 Anderson Alencar. All rights reserved.
//

import Foundation
import UIKit

class WaitLoadViewModel: WaitLoad {
    
    let tabBar = MainTabBarViewController()
    
    var referenceDelegate: WaitLoadViewController?
    
    
    func initTab() {
        let controller = tabBar.viewControllers?.first as! UINavigationController
        let discover = controller.topViewController as! DiscoverViewController
        discover.waitLoadReference = referenceDelegate
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

protocol WaitLoad {
    func presentDiscoverController() -> Void
    func initTab() -> Void
}
