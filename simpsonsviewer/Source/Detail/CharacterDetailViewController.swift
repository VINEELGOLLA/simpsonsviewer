//
//  CharacterDetailViewController.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
   
    var character: RelatedTopic? {
        didSet {
          refreshUI()
        }
      }
    
    @IBOutlet weak var cheracterDetail: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func refreshUI() {
      loadViewIfNeeded()
        let titlenDescription = character?.text?.split(separator: "-")
        
        if let parts = titlenDescription {
            if parts.count > 0 {
                let title = parts[0]
                self.characterName.text = String(title)
            }
            
            if parts.count > 1 {
                let description = parts[1]
                self.cheracterDetail.text = String(description)
            }
        }

        if let posterPath = character?.icon?.url, !posterPath.isEmpty {
            movieImage.downloaded(from: posterPath)
        } else {
            self.movieImage.image = #imageLiteral(resourceName: "placeholder")
        }
    }
}

extension CharacterDetailViewController: CharacterSelectionDelegate {
  func characterSelected(_ selectedCharacter: RelatedTopic) {
    character = selectedCharacter
  }
}
