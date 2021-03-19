//
//  News.swift
//  NewsApp
//
//  Created by Samoilik Hleb on 3/16/21.
//

import Foundation

/*
 "source": {
 "id": "the-verge",
 "name": "The Verge"
 },
 "author": "Andrew J. Hawkins",
 "title": "Elon Musk crowns himself ‘Technoking’ of Tesla",
 "description": "Tesla CEO Elon Musk is now also “technoking,” according to a recent filing with the US Securities and Exchange Commission. Tesla’s CFO Zach Kirkhorn is also changing his title to “Master of Coin.”",
 "url": "https://www.theverge.com/2021/3/15/22331315/elon-musk-tesla-technoking-title-ceo",
 "urlToImage": "https://cdn.vox-cdn.com/thumbor/7YChMVyltceCz6Kv5UXXSoTpXBY=/0x146:2040x1214/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/15971132/elon_musk_tesla_3225.jpg",
 "publishedAt": "2021-03-15T11:06:01Z",
 "content": "CFO Zach Kirkhorn is now Master of Coin\r\nPhoto by Sean OKane / The Verge\r\nElon Musk has a new title at Tesla: Technoking.\r\nThe electric automaker announced the head-scratching sobriquet in a filing w… [+697 chars]"
 */

struct News: Decodable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct NewsCover: Decodable {
    
    let status: String
    let totalResults: Int
    let articles: [News]
}
