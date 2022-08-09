//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 09.08.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

        
    

    private lazy var postImageView: UIImageView = {
       let postImageView = UIImageView()
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.backgroundColor = .black
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = true
        
        return postImageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 50
        return descriptionLabel
    }()
    
    private lazy var authorLabel: UILabel = {
       let authorLabel = UILabel()
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        return authorLabel
    }()
    
    private lazy var likesLabel: UILabel = {
     let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesLabel
    }()

    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewsLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
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

        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 16),
            self.postImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.postImageView.widthAnchor),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.likesLabel.topAnchor, constant: -16),
            
            self.likesLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.likesLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),

            self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)

            
        
        
        
        
        ])
    }
   



}

