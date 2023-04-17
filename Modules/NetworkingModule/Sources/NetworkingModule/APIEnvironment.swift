//  APIEnvironment.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation

public enum APIEnvironment {
    
    enum Keys {
        static let BaseURL = "BASEURL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    public static func getHost() -> String {
        guard let value = APIEnvironment.infoDictionary[Keys.BaseURL] as? String else {
            fatalError("time out key cannot be found")
        }
        return value
    }
}
