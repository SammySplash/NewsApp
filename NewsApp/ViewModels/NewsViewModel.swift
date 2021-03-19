//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Samoilik Hleb on 3/16/21.
//

import Foundation

//MARK: - ViewModel
struct NewsViewModel {
    
    let news: News
    
    var author: String {
        return news.author ?? "Unknown"
    }
    
    var title: String {
        return news.title ?? "No title"
    }
    
    var description: String {
        return news.description ?? "No description"
    }
    
    var url: String {
        return news.url ?? "No url"
    }
    
    var urlToImage: String {
        return news.urlToImage ?? "https://www.kindpng.com/picc/m/182-1827064_breaking-news-banner-png-transparent-transparent-background-breaking-news.png"
    }
}
