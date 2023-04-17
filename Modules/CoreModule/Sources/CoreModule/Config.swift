//  Config.swift
//  Created by Precious Osaro on 16/04/2023.

import Foundation

public enum Config {
  public static func stringValue(forKey key: ConfigKeys) -> String {
      guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
    else {
          fatalError("Invalid value or undefined key \(key.rawValue)")
    }
    return value
  }
}

public enum ConfigKeys: String {
    case baseURL = "BASEURL"
}
