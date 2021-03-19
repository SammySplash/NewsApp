//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Samoilik Hleb on 3/17/21.
//

import UIKit

//MARK: - TableViewCell
class NewsTableViewCell: UITableViewCell {
    
    static let reuseID = "news"
 
    //MARK: - Create Model
    var newsViewModel: NewsViewModel? {
        didSet {
            if let newsViewModel = newsViewModel {
                titleLabel.text = newsViewModel.title
                NetworkManager.shared.getImage(urlString: newsViewModel.urlToImage) { data in  //get image
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.newsImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    //MARK: - Get images
    var newsImageData: Data? {
        didSet {
            if let data = newsImageData {
                newsImage.image = UIImage(data: data)
            }
        }
    }
    
    //MARK: - Get Shadow
    private lazy var newsImage: ShadowImageView = {
        let image = ShadowImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Get Title
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Устанавливаем 0 чтобы ячейка могла расширяться в зависимости от того, сколько строк ей потребуется (пока возвращается API).
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(newsImage)
        
        setupConstrains()
    }
    
    func setupConstrains() {
        //MARK: - News Image
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        //MARK: - Title
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
