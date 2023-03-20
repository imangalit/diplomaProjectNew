//
//  MenuView.swift
//  diplomaProject
//
//  Created by Имангали on 3/18/23.
//

import UIKit

class MenuView: UIView, UISearchBarDelegate {
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Найти"
        searchBar.searchTextField.backgroundColor = UIColor(red: 0.082, green: 0.308, blue: 0.517, alpha: 1)
        searchBar.searchTextField.textColor = UIColor(red: 0.631, green: 0.725, blue: 0.808, alpha: 1)
        searchBar.barTintColor = UIColor(red: 0.102, green: 0.368, blue: 0.613, alpha: 1)
        searchBar.searchTextField.leftView?.tintColor = UIColor(red: 0.631, green: 0.725, blue: 0.808, alpha: 1)
        let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchTextField?.attributedPlaceholder = NSAttributedString(string: "Найти", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.631, green: 0.725, blue: 0.808, alpha: 1)])
        return searchBar
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.102, green: 0.368, blue: 0.613, alpha: 1)
        layer.cornerRadius = 10
        //addSubview(searchBar)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar.delegate = self
    }
    
    override func layoutSubviews() {
//        super.layoutSubviews()
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        self.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            searchBar.widthAnchor.constraint(equalToConstant: frame.size.width - 20),
//            searchBar.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        print(searchBar.frame)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
}
