//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.08.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    let coreManager = CoreDataManager.shared
    var isLike = UserDefaults.standard.bool(forKey: "isLike")
    private lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.backgroundColor = .black
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = true
        postImageView.isUserInteractionEnabled = true
        return postImageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return descriptionLabel
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorLabel.textColor = .black
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.numberOfLines = 2

        return authorLabel
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textColor = .black
        likesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        return likesLabel
    }()
    
    private lazy var likeButton: UIButton = {
        let likeImage = UIButton(type: .custom)
        likeImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        likeImage.translatesAutoresizingMaskIntoConstraints = false
        likeImage.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        likeImage.tintColor = isLike ? .systemRed : .lightGray
        likeImage.addTarget(self, action: #selector(tapLike), for: .touchUpInside)
        return likeImage
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        return viewsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.imageViewGesture()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: Post) {
        self.postImageView.image = UIImage(named: viewModel.image )
        self.authorLabel.text = viewModel.author
        self.descriptionLabel.text = viewModel.description
        self.viewsLabel.text =  "Views: \(viewModel.views)"
        self.likesLabel.text = "Likes: \(viewModel.likes)"
    }
    
    func setupView() {
        self.contentView.addSubview(postImageView)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(viewsLabel)
        self.contentView.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 16),

            self.postImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.postImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),

            self.postImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.postImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.postImageView.widthAnchor),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.likesLabel.topAnchor, constant: -16),
            
            self.likeButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            self.likeButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.likeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            
            self.likesLabel.centerYAnchor.constraint(equalTo: self.likeButton.centerYAnchor),
            self.likesLabel.leadingAnchor.constraint(equalTo: self.likeButton.trailingAnchor, constant: 5),
            
            self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
            
            
            
            
            
            
        ])
    }
    
    func imageViewGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapLike))
        gesture.numberOfTapsRequired = 2
        self.postImageView.addGestureRecognizer(gesture)
    }
    
    
    @objc private func tapLike() {
        let likes =  self.likesLabel.text ?? ""
        let authorText = self.authorLabel.text ?? ""
        let postImage = self.postImageView.image?.pngData()
        let views = self.viewsLabel.text ?? ""
        let descriptionText = self.descriptionLabel.text ?? ""
        let like = Like(context: coreManager.persistentContainer.viewContext)
        
        if isLike == true {
            coreManager.deleteLike(like: like)
            UserDefaults.standard.set(false, forKey: "isLike")
        } else if isLike == false {
            coreManager.createLike(authorText: authorText, descriptionText: descriptionText, likes: likes, postImage: postImage!, views: views)
            UserDefaults.standard.set(true, forKey: "isLike")
        }
        
        
        
        
//       
        likeButton.tintColor = isLike ? .systemRed : .lightGray
        
    }
}

