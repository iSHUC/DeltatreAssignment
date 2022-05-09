//
//  HomeViewController.swift
//  DeltatreAssignment
//
//  Created by Ishwar on 01/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - Properties
    
    private let sections = [
        [
            "title": "TRENDING MOVIES",
            "pictures": [
                UIImage(named: "kgfchapter2"),
                UIImage(named: "rrr"),
                UIImage(named: "kashmirfiles"),
                UIImage(named: "bahubali2"),
                UIImage(named: "bachchanpandey"),
                UIImage(named: "pushpa")
            ]
        ],
        [
            "title": "POPULAR SERIES",
            "pictures": [
                UIImage(named: "dbz"),
                UIImage(named: "4x4"),
                UIImage(named: "superman"),
                UIImage(named: "spiderman"),
                UIImage(named: "naruto"),
                UIImage(named: "ironman")
            ]
        ],
        [
            "title": "RECOMMENDED SHOWS",
            "pictures": [
                UIImage(named: "bb2"),
                UIImage(named: "dangal"),
                UIImage(named: "sanju"),
                UIImage(named: "simmba"),
                UIImage(named: "kbsingh"),
                UIImage(named: "heropanti2")
            ]
        ]
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

// MARK: - Configure Views

extension HomeViewController {
    
    private func configureViews() {
        
        view.backgroundColor = .systemBackground
        
        configureTableView()
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Table View Data Source

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            
            return UITableViewCell()
        }
        
        if let pictures = sections[indexPath.section]["pictures"] as? [UIImage?] {
            
            cell.configure(pictures)
        }
        
        return cell
    }
}

// MARK: - Table View Delegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // Returning the calculated height based on section number
        CGFloat((sections.count - indexPath.section) * 100)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        sections[section]["title"] as? String
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    }
}
