//
//  Errors.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import Foundation

enum appError: Error{
    case networkError
    case urlError
    case jsonError
    case NoResult
    case EmptySearchBar
    
    var message: String {
        switch self {
        case .jsonError:
            return "Something went wrong while decoding result"
        case .networkError:
            return "Something went wrong while accessing api"
        case .urlError:
            return "Remove empty spaces"
        case .NoResult:
            return "No result Found"
        case .EmptySearchBar:
            return "Please Enter the Character Name"
        }
    }
    
    var title: String {
        switch self {
        case .jsonError:
            return "JsonError"
        case .networkError:
            return "NetworkError"
        case .urlError:
            return "UrlError"
        case .NoResult:
            return "No Result"
        case .EmptySearchBar:
            return "SearchBar Empty"
        }
    }
}
