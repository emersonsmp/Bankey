//
//  Localstate.swift
//  Bankey
//
//  Created by Emerson Sampaio on 03/04/23.
//

import Foundation

public class LocalState {
    
    private enum Keys: String{
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get{
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set(newValue){
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
            //UserDefaults.standard.synchronize()
            //As of iOS 12 synchronized is no longer required when writing too NSUserDefaults.
        }
    }
    
}
