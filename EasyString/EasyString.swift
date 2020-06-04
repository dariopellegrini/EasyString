//
//  EasyString.swift
//  EasyString
//
//  Created by Dario Pellegrini on 02/06/2020.
//  Copyright © 2020 Dario Pellegrini. All rights reserved.
//

import Foundation

public extension String {
    
    // MARK: Index
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func index(of character: Character) -> Int? {
        return self.firstIndex(of: character)?.utf16Offset(in: self)
    }
    
    func firstIndex(of string: String) -> Int? {
        return self.range(of: string)?.lowerBound.utf16Offset(in: self)
    }
    
    func lastIndex(of string: String) -> Int? {
        return self.range(of: string, options: .backwards)?.lowerBound.utf16Offset(in: self)
    }
    
    // MARK: Substrings
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return self[fromIndex...].string
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return self[..<toIndex].string
    }

    func substring(range: Range<Int>) -> String {
        let startIndex = index(from: range.lowerBound)
        let endIndex = index(from: range.upperBound)
        return self[startIndex..<endIndex].string
    }
    
    func substring(before: String) -> String {
        if let range = self.range(of: before) {
            return self[self.startIndex..<range.lowerBound].string
        }
        return self
    }
    
    func substring(after: String) -> String {
        if let range = self.range(of: after) {
            return self[range.upperBound...].string
        }
        return self
    }
    
    func between(_ l: String, _ r: String) -> String {
        if let rangeLeft = self.range(of: l),
            let rangeRight = self.range(of: r) {
            return self[rangeLeft.upperBound..<rangeRight.lowerBound].string
        }
        return self
    }
    
    
    // MARK: - Replace
    func replace(_ occurencesOf: String, with: String) -> String {
        return self.replacingOccurrences(of: occurencesOf, with: with)
    }
    
    func replace(_ occurencesOf: String..., with: String) -> String {
        var result = self
        occurencesOf.forEach {
            s in
            result = result.replacingOccurrences(of: s, with: with)
        }
        return result
    }
    
    func replace(regularExpression: String, with: String) -> String {
        return self.replacingOccurrences(of: regularExpression, with: with, options: .regularExpression)
    }
    
    // MARK: - Is number
    var isNumber: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }
    
    // MARK: - Is alphabetic
    var isAlphabetic: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    // MARK: - Is alphanumeric
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    // MARK: - Extractions of characters
    var numberString: String {
        return replace(regularExpression: "[^0-9]", with: "")
    }
    
    var alphabeticString: String {
        return replace(regularExpression: "[^a-zA-Z]", with: "")
    }
    
    var alphanumericString: String {
        return replace(regularExpression: "[^a-zA-Z0-9]", with: "")
    }
    
    //MARK: - Charachter set
    var set: CharacterSet {
        return CharacterSet(charactersIn: self)
    }
    
    // MARK: - String
    func split(_ separator: String) -> [String] {
        return self.components(separatedBy: separator)
    }
    
    func split(_ set: CharacterSet) -> [String] {
        return self.components(separatedBy: set)
    }
    
    // MARK: - Camel case
    var camelCase: String {
        return self.lowercased()
            .replace("-", with: " ")
            .replace("_", with: " ")
            .split(separator: " ")
            .map { return $0.lowercased().capitalized }
            .joined()
    }
    
    // MARK: - Snake case
    var snakeCase: String {
        return self.lowercased()
            .replace("-", with: " ")
            .replace("_", with: " ")
            .split(separator: " ")
            .map { return $0.lowercased() }
            .join("_")
    }
    
    // MARK: - Latin
    var latin: String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
    
    // MARK: - Lines
    var lines: [String] {
        return self.components(separatedBy: CharacterSet.newlines)
    }
    
    // MARK: - Slugging
    func slugify(withSeparator separator: String = "-") -> String {
        let slugCharacterSet = NSCharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\(separator)")
        return latin
            .lowercased()
            .components(separatedBy: slugCharacterSet.inverted)
            .filter { $0 != "" }
            .join(separator)
       }
    
    // MARK: - Is empty
    var isEmpty: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
    }
    
    // MARK: - Collapse whitespaces
    func collapseWhiteSpaces() -> String {
        return components(separatedBy: CharacterSet.whitespacesAndNewlines)
            .filter { $0.isEmpty == false }
            .joined(separator: " ")
    }
    
    // MARK: - Prefix
    func has(prefix: String) -> Bool {
        return self.hasPrefix(prefix)
    }
    
    func remove(prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func removePrefix(before: String, included: Bool = false) -> String {
        guard let index = self.firstIndex(of: before) else { return self }
        return self.substring(from: included == true ? index + 1 : index)
    }
    
    // MARK: - Suffix
    func has(suffix: String) -> Bool {
        return self.hasSuffix(suffix)
    }
    
    func remove(suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    func removeSuffix(after: String, included: Bool = false) -> String {
        guard let index = self.lastIndex(of: after) else { return self }
        return self.substring(to: included == true ? index : index + 1)
    }
    
    // MARK: - Trim
    func trim(in set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        return self.trimmingCharacters(in: set)
    }
    
    func trimLeft(in set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        return self.replace(regularExpression: "^\\s+", with: "")
    }
    
    func trimRight(in set: CharacterSet = CharacterSet.whitespacesAndNewlines) -> String {
        return self.replace(regularExpression: "\\s+$", with: "")
    }
    
    // MARK: - Pad
    func pad(_ string: String, times: Int) -> String {
        let pad = (0..<times).reduce("") {
            acc, value in
            "\(acc)\(string)"
        }
        return pad + self + pad
    }
    
    func padLeft(_ string: String, times: Int) -> String {
        return (0..<times).reduce("") {
            acc, value in
            "\(acc)\(string)"
        } + self
    }
    
    func padRight(_ string: String, times: Int) -> String {
        return self + (0..<times).reduce("") {
            acc, value in
            "\(acc)\(string)"
        }
    }
    
    // MARK: - Number of occurencies
    func count(string: String) -> Int {
        return self.split(string).count - 1
    }
    
    // MARK: - Conversions
    func toBool() -> Bool? {
        return Bool(self)
    }
    
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toFloat() -> Float? {
        return Float(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
    
    // MARK: - Initials
    var initials: String {
        return self.components(separatedBy: CharacterSet.init(charactersIn: " -_\n\r")).map {
            $0.substring(to: 1).capitalized
        }.join(" ")
    }
    
    // MARK: - Subscripts
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    subscript(i: Int) -> String {
        get {
            return self.substring(range: i..<i+1)
        }
    }
}

public extension Array where Element == String {
    func join(_ separator: String) -> String {
        return self.joined(separator: separator)
    }
}

public extension Substring {
    var string: String {
        return String(self)
    }
}
