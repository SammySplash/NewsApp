//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Samoilik Hleb on 3/16/21.
//

// http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c96097b6798c46b0a7d341b58f40f6bd

//MARK :  Use NSCache in order to cache doesn’t use too much of the system’s memory (NSCache<KeyType, ObjectType>)
import Foundation


enum Filter: String {
    case country = "top-headlines?country=us" //Getting news feed from the chosen country
    case tech = "top-headlines?sources=techcrunch"
    case auto = "everything?q=tesla&from=2021-02-19&sortBy=publishedAt"
}


class NetworkManager {
    
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {} // limit initialization
    
    private let baseURLString = "https://newsapi.org/v2/" //common between all the other types of API of news articles categories. Very important insert "htppS" instead of "http".
    
    func getNews(filter: Filter, completion: @escaping ([News]?) -> Void) {
        let urlString = "\(baseURLString)\(filter.rawValue)&apiKey=\(APIKey.key)"
        guard let url = URL(string: urlString) else { return }
        
        //MARK: - Create URLSession
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            print(response.statusCode)
            
            //MARK: - Extract NewsCover from JSONDecoder
            let newsCover = try? JSONDecoder().decode(NewsCover.self, from: data)
            newsCover == nil ? completion(nil) : completion(newsCover?.articles)
            
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        //MARK: - Проверяем наш кэш изображений и говорим, что у нас есть объект. Когда один и тот же URL-адрес вызывается для одного и того же URL-изображения - мы проверяем кэш и возвращаем изображение из него, вместо того чтобы создавать новый запрос в сеть.
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            //MARK: - Сперва изображения загружаются здесь через сеть, а затем сохраняются в кэше (при прокрутке, допустим, вверх и вниз изображения сохраняются).
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else { return }
                print(response.statusCode)
                
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
    
}
