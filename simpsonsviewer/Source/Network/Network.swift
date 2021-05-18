//
//  Network.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import Foundation

class Network {
    
    func fetchDataWith(onCompletion : @escaping (Result<CharacterDataModel,Error>) -> Void) {
        
        let url = SharedInfo.shared.url
        
        guard let stringUrl = URL(string: url) else {
            onCompletion(.failure(appError.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: stringUrl, completionHandler: { data, urlResponse, error in
            if let _ = error {
                onCompletion(.failure(appError.networkError))
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(CharacterDataModel.self, from: data)
                        onCompletion(.success(response))
                    } catch _ {
                        onCompletion(.failure(appError.jsonError))
                    }
                }
        }).resume()
    }
}
