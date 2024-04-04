//
//  APError.swift
//  Appetizers
//
//  Created by parth kanani on 27/02/24.
//

import Foundation

enum APError: Error
{
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete  // we are going to use this for generel error like wifi turns off
}
