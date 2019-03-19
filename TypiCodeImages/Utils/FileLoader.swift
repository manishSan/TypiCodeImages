//
//  JSONLoader.swift
//  TypiCodeImages
//
//  Created by manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation

/// A utility class designed to facilitate loading JSON from a given file on the filesystem
final class FileLoader {

    /// Load json file and return data
    ///
    /// - Parameter filename: The of the JSON file to look for -- do not include the file's extension
    /// - Returns: Json file Data. Returns nil if it can't find the file.
    func loadJSON(filename: String) -> Data? {
        guard let jsonFilePath = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json"),
            let jsonString = try? String(contentsOfFile: jsonFilePath),
            let jsonData = jsonString.data(using: String.Encoding.utf8)
            else { return nil }

        return jsonData
    }

    /// Load a file from bundle and return data
    ///
    /// - Parameter filename: a filename with extension
    /// - Returns: Json file Data. Returns nil if it can't find the file.
    func loadFile(name: String) -> Data? {
        guard let fileContent = try? String(contentsOfFile: name),
            let data = fileContent.data(using: String.Encoding.utf8) else {
                return nil
        }
        return data
    }
}
