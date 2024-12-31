//
//  Environment.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/31/24.
//

import Foundation

enum Environment {
  static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
