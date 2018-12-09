//
//  RootViewController.swift
//  marvels
//
//  Created by Aitor Pagán on 06/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet var optionsTableView: UITableView!
    
    var dataSource: [OptionsData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "OptionsTableViewCell")
        optionsTableView.tableFooterView = UIView()
        dataSource = OptionsFactory.makeAvailableOptions()
        optionsTableView.reloadData()
    }

}

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell", for: indexPath) as! OptionsTableViewCell
        
        cell.updateUI(dataSource[indexPath.row].title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(dataSource[indexPath.row].viewController, animated: true)
    }
}

private class OptionsTableViewCell: UITableViewCell {
    
    func updateUI(_ text: String?) {
        self.textLabel?.text = text
    }
}
