//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Emerson Sampaio on 03/04/23.
//

import UIKit

extension UIViewController {
    
    func setStatusbar(){
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBarView = UIView(frame: frame)

        statusBarView.backgroundColor = appColor
        view.addSubview(statusBarView)
    }
    
//    func setStatusBar() {
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithTransparentBackground()
//        navBarAppearance.backgroundColor = appColor
//        UINavigationBar.appearance().standardAppearance = navBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//    }
    
    func setTabBarImage(imageName: String, title: String){
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
