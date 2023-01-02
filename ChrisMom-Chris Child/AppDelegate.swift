//
//  AppDelegate.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 23/12/22.
//

import SwiftUI
import UIKit
import FirebaseCore
import FirebaseFirestore
// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(">> your code here !!")
        return true
    }
}



@main
struct Testing_SwiftUI2App: App {

    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GameService())
        }
    }
}
