//
//  ViewController.swift
//  NewsApp
//
//  Created by Samoilik Hleb on 3/16/21.
//

import UIKit
import SafariServices //For use Safari ViewController

class ViewController: UIViewController, UISearchBarDelegate {
    
    var viewModel = NewListViewModel()
    
    var refreshControl = UIRefreshControl()
    
    private lazy var headerView: HeaderView = {
        let headerView = HeaderView(fontSize: 32)
        headerView.countryButton.addTarget(self, action: #selector(handleCountry), for: .touchUpInside)
        headerView.techButton.addTarget(self, action: #selector(handleTech), for: .touchUpInside)
        headerView.automobileButton.addTarget(self, action: #selector(handleAutomobile), for: .touchUpInside)
        return headerView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        fetchNews(.country)
        headerView.countryButton.backgroundColor = .black
        headerView.countryButton.setTitleColor(UIColor.white, for: .normal)
        
        refreshControl.attributedTitle = NSAttributedString(string: "↓ Pull To Refresh ↓")
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        tableView.addSubview(refreshControl)
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(searchBar)
        setupConstrains()
    }
    
    func setupConstrains() {
        //MARK: - Header
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.heightAnchor.constraint(equalToConstant: 100),
        ])
        //MARK: - SearchBar
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        //MARK: - TableView
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNews(_ filter: Filter? = nil, completion: (() -> Void)? = nil) {
        viewModel.getNews(filter: filter) { _ in
            self.tableView.reloadData()
            completion?()
        }
    }
    
    //MARK: - SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            viewModel.newsVM = viewModel.initialNews
            tableView.reloadData()
            return
        }
        
        viewModel.newsVM = viewModel.initialNews.compactMap { (newsModel) -> NewsViewModel? in
            guard newsModel.title.contains(searchText) else {
                return nil
            }
            return newsModel
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    @objc func handleCountry() {
        fetchNews(.country)
        
        headerView.countryButton.backgroundColor = .black
        headerView.countryButton.setTitleColor(UIColor.white, for: .normal)
        
        headerView.techButton.backgroundColor = .white
        headerView.techButton.setTitleColor(UIColor.black, for: .normal)
        
        headerView.automobileButton.backgroundColor = .white
        headerView.automobileButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func handleTech() {
        fetchNews(.tech)
        
        headerView.countryButton.backgroundColor = .white
        headerView.countryButton.setTitleColor(UIColor.black, for: .normal)
        
        headerView.techButton.backgroundColor = .black
        headerView.techButton.setTitleColor(UIColor.white, for: .normal)
        
        headerView.automobileButton.backgroundColor = .white
        headerView.automobileButton.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func handleAutomobile() {
        fetchNews(.auto)
        
        headerView.countryButton.backgroundColor = .white
        headerView.countryButton.setTitleColor(UIColor.black, for: .normal)
        
        headerView.techButton.backgroundColor = .white
        headerView.techButton.setTitleColor(UIColor.black, for: .normal)
        
        headerView.automobileButton.backgroundColor = .black
        headerView.automobileButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    @objc func handleRefresh(sender: UIRefreshControl) {
        refreshControl.beginRefreshing()
        fetchNews() {
            self.refreshControl.endRefreshing()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.reuseID,
            for: indexPath
        ) as? NewsTableViewCell
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsViewModel = news
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        guard let url = URL(string: news.url) else { return }
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .formSheet
        present(safariViewController, animated: true)
    }
}

