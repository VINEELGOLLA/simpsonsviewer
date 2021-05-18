//
//  Alerter.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import Foundation
import UIKit

protocol Alerter {
    func alert(error: Error)
}

extension Alerter {
    func alert(error: Error) {
        var title = "Error"
        var message = error.localizedDescription
        let cancelAction = UIAlertAction(title: "Okay", style: .cancel)

        
        if let characterError = error as? appError {
            message = characterError.message
            title = characterError.title
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(cancelAction)
        
        UIApplication.getPresentedVC()?.present(alert, animated: true, completion: nil)
    }
}
