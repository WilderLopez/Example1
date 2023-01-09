//
//  Helper+UserDefaults.swift
//  EvaluacionIOS
//
//  Created by Wilder Lopez on 12/23/22.
//

import Foundation

class HelperApp{
    static let shared = HelperApp()
    
    //La idea general era usar CoreData pero como comenzo a darme problemas preferí temrinar usando UsersDefaults, en una situacion real se utilizaria coredata, pero acá no tengo el tiempo del mundo para eso :)
    
    func save(name: String) {
        UserDefaults.standard.set(name, forKey: AppUserDefaultKeys.USER_NAME.rawValue)
    }
    
    func save(firstLastname: String){
        UserDefaults.standard.set(firstLastname, forKey: AppUserDefaultKeys.FIRST_LASTNAME.rawValue)
    }
    func save(secondLastname: String) {
        UserDefaults.standard.set(secondLastname, forKey: AppUserDefaultKeys.SECOND_LASTNAME.rawValue)
    }
    
    func save(gender: String) {
        UserDefaults.standard.set(gender, forKey: AppUserDefaultKeys.GENDER.rawValue)
    }
    
    func getName() -> String? {
        UserDefaults.standard.value(forKey: AppUserDefaultKeys.USER_NAME.rawValue) as? String
    }
    
    func getFirstLastname() -> String? {
        UserDefaults.standard.value(forKey: AppUserDefaultKeys.FIRST_LASTNAME.rawValue) as? String
    }
    
    func getSecondLastname() -> String? {
        UserDefaults.standard.value(forKey: AppUserDefaultKeys.SECOND_LASTNAME.rawValue) as? String
    }
    
    func getGender() -> String? {
        UserDefaults.standard.value(forKey: AppUserDefaultKeys.GENDER.rawValue) as? String
    }
}

enum AppUserDefaultKeys : String {
    case USER_NAME, FIRST_LASTNAME, SECOND_LASTNAME, GENDER
}
