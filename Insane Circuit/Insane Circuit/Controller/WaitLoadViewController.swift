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
    
    let viewModel = WaitLoadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.referenceDelegate = self
        animationView = AnimationView(name: "galaxy")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        
        animationView?.animationSpeed = 0.3
        view.addSubview(animationView!)
        animationView?.backgroundColor = .backgroundBlueColor
        animationView?.play()
        animationView?.loopMode = .loop
        viewModel.initTab()
    }
}
