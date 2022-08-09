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

    private lazy var descriptionText: UITextView = {
        let descriptionText = UITextView()
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.clipsToBounds = true
        return descriptionText
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
        self.descriptionText.text = viewModel.description
        self.viewsLabel.text =  "Views: \(viewModel.views)"
        self.likesLabel.text = "Likes: \(viewModel.likes)"
    }
    
    func setupView() {
        self.contentView.addSubview(postImageView)
        self.contentView.addSubview(descriptionText)
        self.contentView.addSubview(authorLabel)
        self.contentView.addSubview(likesLabel)
        self.contentView.addSubview(viewsLabel)

        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 16),
            self.postImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.postImageView.widthAnchor, multiplier: 1.0),
            self.postImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.descriptionText.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.descriptionText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.descriptionText.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.likesLabel.topAnchor.constraint(equalTo: self.descriptionText.bottomAnchor, constant: 16),
            self.likesLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),

            self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionText.bottomAnchor, constant: 16),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)

            
        
        
        
        
        ])
    }
   



}

