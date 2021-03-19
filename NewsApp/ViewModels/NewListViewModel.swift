//
//  NewListViewModel.swift
//  NewsApp
//
//  Created by Samoilik Hleb on 3/17/21.
//

import Foundation

//MARK: - List View Model
class NewListViewModel {
    
    var initialNews = [NewsViewModel]()
    var newsVM = [NewsViewModel]()
    
    private var currentNewsFilter: Filter?
    
    func getNews(filter: Filter? = nil, completion: @escaping ([NewsViewModel]) -> Void) {
        if let filter = filter {
            currentNewsFilter = filter
        }
        
        guard let relevantFilter = filter ?? currentNewsFilter else {
            return
        }
        
        NetworkManager.shared.getNews(filter: relevantFilter) { news in
            guard let news = news else { return }
            let newsVM = news.map(NewsViewModel.init)
            
            //MARK: - основная очередь, аснхронность для быстродействия.
            DispatchQueue.main.async {
                self.newsVM = newsVM
                self.initialNews = newsVM
                completion(newsVM)
            }
        }
    }
}
