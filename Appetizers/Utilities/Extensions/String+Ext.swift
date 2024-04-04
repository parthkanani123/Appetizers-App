//
//  String+Ext.swift
//  Appetizers
//
//  Created by parth kanani on 30/03/24.
//

import Foundation
import RegexBuilder

extension String 
{
    var isValidEmail: Bool
    {
        // MARK: - iOS 15
        
//        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
//        return emailPredicate.evaluate(with: self)
        
        
        // MARK: - iOS 16
        // let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", remove " " and add / / and then right click -> refactor -> convert to regxbuilder. this give following code
        
        let emailRegex         = Regex {
            OneOrMore {
                CharacterClass(
                    .anyOf("._%+-"),
                    ("A"..."Z"),
                    ("0"..."9"),
                    ("a"..."z")
                )
            }
            "@"
            OneOrMore {
                CharacterClass(
                    .anyOf("-"),
                    ("A"..."Z"),
                    ("a"..."z"),
                    ("0"..."9")
                )
            }
            "."
            Repeat(2...64) {
                CharacterClass(
                    ("A"..."Z"),
                    ("a"..."z")
                )
            }
        }
        
        // if our email match to this format it's not nil, so return true, otherwise it's == nil, so return false
        return self.wholeMatch(of: emailRegex) != nil
    }
}
