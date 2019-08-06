//
//  AppDelegate.swift
//  RealmPlayground
//
//  Created by Hitesh  Agarwal on 03/08/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      print("\nDocument Directory: \(documentsPathURL.absoluteString)")
    }
    return true
  }
  
  
}


