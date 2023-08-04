//
//  UINavigationControllerExtension.swift
//  Avtomobilka
//
//  Created by Vladimir Vaskin on 29.07.2023.
//

import UIKit

extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarAppearance = navBarAppearance()
        
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.compactAppearance = navBarAppearance
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.compactScrollEdgeAppearance = navBarAppearance
    }

    func navBarAppearance() -> UINavigationBarAppearance {
        let navBarAppearance = UINavigationBarAppearance()

        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "barColor")
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        return navBarAppearance
    }
}
