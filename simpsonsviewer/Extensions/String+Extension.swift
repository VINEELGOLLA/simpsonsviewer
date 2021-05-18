//
//  String+Extension.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import Foundation

extension String {
    func removeWhiteSpaces(query: String) -> String? {
        var searchText = ""
        searchText = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if searchText.isEmpty {
            return nil
        }
        
        return searchText
    }
}
