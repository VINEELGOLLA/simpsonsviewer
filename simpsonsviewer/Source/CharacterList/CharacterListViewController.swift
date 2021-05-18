//
//  CharacterListViewController.swift
//  simpsonsviewer
//
//  Created by naga vineel golla on 5/16/21.
//

import UIKit

protocol CharacterSelectionDelegate: class {
  func characterSelected(_ selectedCharacter: RelatedTopic)
}

class CharacterListViewController : UIViewController, Alerter {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var Go: UIButton!
    @IBOutlet weak var CharacterListTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    
    weak var delegate: CharacterSelectionDelegate?
    let networkManager = Network()
    private var CharacterList: [RelatedTopic]? {
        didSet {
            DispatchQueue.main.async {
                self.CharacterListTableView.reloadData()
                if let firstCharacter = self.CharacterList?[0] {
                    self.delegate?.characterSelected(firstCharacter)
                }
            }
        }
    }
    
    private var fileredList: [RelatedTopic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        title = SharedInfo.shared.title
        searchBar.delegate = self
        CharacterListTableView.delegate = self
        CharacterListTableView.dataSource = self

        CharacterListTableView.tableFooterView = UIView()
        CharacterListTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.defalultCellIdentifier)
        Go.addTarget(self, action: #selector(goButton), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapView(_:)))
        backgroundView.addGestureRecognizer(tap)

        fetchData()
    }
    
    @objc fileprivate func goButton() {
        searchBarSearchButtonClicked(searchBar)
    }
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
    
    func fetchData() {
        networkManager.fetchDataWith() { [weak self] result in
            switch result {
            case .success(let characterData):
                DispatchQueue.main.async {
                    self?.CharacterList = characterData.relatedTopics
                    if (characterData.relatedTopics?.isEmpty ?? true) {
                        self?.alert(error: appError.NoResult)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.alert(error: error)
                }
            }
        }
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = self.searchBar.text,
              !text.isEmpty,
              let searchText = text.removeWhiteSpaces(query: text),
              !searchText.isEmpty else {
            searchBar.text = nil
            self.CharacterListTableView.reloadData()
            self.searchBar.resignFirstResponder()
            self.alert(error: appError.EmptySearchBar)
            return
        }
        self.searchBar.resignFirstResponder()

        let filter = self.CharacterList?.filter({ $0.text?.hasPrefix(searchText) ?? false})
        
        self.fileredList = filter
        
        self.CharacterListTableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
            return searchBar.text?.isEmpty ?? true
        }
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchBarIsEmpty() {
            return fileredList?.count ?? 0
        } else {
            return CharacterList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath) as?  CharacterListTableViewCell else {
                   return UITableViewCell(style: .default, reuseIdentifier: Constants.defalultCellIdentifier)
                }
        let parts: [String.SubSequence]?
        let result: RelatedTopic?
        if !searchBarIsEmpty() {
            result = fileredList?[indexPath.row]
            parts = result?.text?.split(separator: "-")
        } else {
            result = CharacterList?[indexPath.row]
            parts = result?.text?.split(separator: "-")
        }
        
        if let title = parts?[0] {
            cell.characterName.text = String(title)
        } else {
            cell.characterName.text = "N/A"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !searchBarIsEmpty() {
            if let selectedCharacter = fileredList?[indexPath.row] {
                delegate?.characterSelected(selectedCharacter)
                if
                  let detailViewController = delegate as? CharacterDetailViewController,
                  let detailNavigationController = detailViewController.navigationController {
                    splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
                }
            }
        } else {
            if let selectedCharacter = CharacterList?[indexPath.row] {
                delegate?.characterSelected(selectedCharacter)
                if
                  let detailViewController = delegate as? CharacterDetailViewController,
                  let detailNavigationController = detailViewController.navigationController {
                    splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
                }
            }
        }
    }
}
