//
//  ProfileViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 16.07.2022.
//

import UIKit
import CoreLocation
import UniformTypeIdentifiers

class ProfileViewController: UIViewController {
    
    let coreManager = CoreDataManager.shared
    let locationManager = CLLocationManager()
    private let viewModel: ProfileViewModelProtocol
    //    private let user: User
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        //        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarView: AvatarView = {
        let avatarView = AvatarView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.delegate = self
        return avatarView
    }()
    
    lazy var profileView: ProfileView = {
        let profileView = ProfileView()
        profileView.avatarImage.image = UIImage(named: "IMG_1824")
        profileView.nameLabel.text = "userName".localized
        profileView.disctiptionLabel.text = " "
        profileView.delegate = self
        
        return profileView
    }()
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGesture()
        self.tabBarController?.tabBar.isHidden = false
        //        UserDefaults.standard.set(false, forKey: "isLike")
        profileView.configureTableView(dataSource: self, delegate: self, dropDelegate: self, dragDelegate: self)
        profileView.delegate = self
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.avatarView.isHidden = true
        profileView.reload()
    }
    
    private func setupView(){
        
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(avatarView)
        self.view.bringSubviewToFront(avatarView)
        
        NSLayoutConstraint.activate([
            
            
            
            self.avatarView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.avatarView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.avatarView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.avatarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.avatarView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ] )
    }
    private var avatarWidthConstraint: NSLayoutConstraint?
    private var avatarHeightConstraint: NSLayoutConstraint?
    
    var isAvatarIncreased = false
    
    
    
    func changeLayoutAvatar() {
        let closeButton = avatarView.closeButton
        let avatarImage = self.avatarView.avatarImageView
        let widthScreen = UIScreen.main.bounds.width
        let widthAvatar = avatarImage.bounds.width
        let width = widthScreen / widthAvatar
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) { [self] in
                self.avatarView.isHidden = false
                self.avatarView.bringSubviewToFront(avatarImage)
                self.avatarView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                avatarImage.transform = self.isAvatarIncreased ? .identity : CGAffineTransform(scaleX: width, y: width)
                avatarImage.layer.borderWidth = self.isAvatarIncreased ? 3 : 0
                avatarImage.center = self.isAvatarIncreased ? CGPoint(x: 63.166666666666664, y: 63.166666666666664) : CGPoint(x: self.avatarView.bounds.midX, y: self.avatarView.bounds.midY)
                avatarImage.layer.cornerRadius = self.isAvatarIncreased ? avatarImage.frame.height/2 : 0
                closeButton.isHidden = self.isAvatarIncreased ? true : false
            }
            
        } completion: { _ in
            self.isAvatarIncreased.toggle()
            if self.isAvatarIncreased == false {
                self.avatarView.isHidden = true
            }
        }
    }
    
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    var string = ""
    var image: UIImage?
    var postDragAtIndex = Int()
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {  let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell1.setup(with: posts[indexPath.row], index: indexPath.row)
            if coreManager.likes.count == 0  {
                UserDefaults.standard.set(false, forKey: "isLike\(indexPath.row)")
                
            }
            
            
            if UserDefaults.standard.bool(forKey: "isLike\(indexPath.row)") == true {
                cell1.likeButton.tintColor = .systemRed
            } else if UserDefaults.standard.bool(forKey: "isLike\(indexPath.row)") == false {
                cell1.likeButton.tintColor = .lightGray
                
            }
            
            
            cell1.delegat = self
            return cell1
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section > 0 {
            return posts.count
        }
        return 0
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        tableView.reloadData()
    //    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 && indexPath.section == 0 {
            //            let vc1 = PhotosViewController()
            //            self.navigationController?.pushViewController(vc1, animated: true)
//            self.viewModel.viewInputDidChange(viewInput: .tapPhotoCell)
        }
        
    }
    
}

extension ProfileViewController: AvatarViewDelegate, ProfileViewDelegate {
    func changeLayout() {
        self.changeLayoutAvatar()
    }
    
    func pushMapView() {
        locationManager.requestWhenInUseAuthorization()
//        self.viewModel.viewInputDidChange(viewInput: .tapMapButton)
    }
}

extension ProfileViewController: CellDelegate {
    func reload() {
        profileView.reload()
    }
}
extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let string = posts[indexPath.row].description
        let image =  posts[indexPath.row].image

        let stringItemProvider = NSItemProvider(object: string as NSItemProviderWriting)

        let imageItemProvider = NSItemProvider(object: image)

        return [UIDragItem(itemProvider: stringItemProvider), UIDragItem(itemProvider: imageItemProvider)]
    }



    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }

        _ = coordinator.session.loadObjects(ofClass: String.self) { string in
            if let str = string.first {
                self.string = str
            }

        }
        _ = coordinator.session.loadObjects(ofClass: UIImage.self) { image in
            if let img = image.first as? UIImage {
                self.image = img
            }
        }
        let newPost = Post(author: "Drag&Drop", description: string, image: image ?? UIImage(systemName: "person")!, likes: 0, views: 0)
        posts.insert(newPost, at: destinationIndexPath.row)
        tableView.reloadData()
    }


    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: String.self) && session.canLoadObjects(ofClass: UIImage.self)

    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy)
    }


}


//@available(iOS 11.0, *)
//extension ProfileViewController: UITableViewDragDelegate, UITableViewDropDelegate {
//
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        guard indexPath.row != 0 else { return [] }
//
//        postDragAtIndex = indexPath.row
//        let post = posts[postDragAtIndex]
//
//        let imageProvider = NSItemProvider(object: post.image as UIImage)
//        let imageDragItem = UIDragItem(itemProvider: imageProvider)
//        imageDragItem.localObject = post.image
//
//        let descriptionProvider = NSItemProvider(object: post.description as NSString)
//        let descriptionDragItem = UIDragItem(itemProvider: descriptionProvider)
//        descriptionDragItem.localObject = post.description
//
//        return [imageDragItem, descriptionDragItem]
//    }
//
//    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
//        return session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSString.self)
//    }
//
//    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
//        guard session.items.count == 2 else {
//            return UITableViewDropProposal(operation: .cancel)
//        }
//
//        if tableView.hasActiveDrag {
//            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
//        } else {
//            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
//        let destinationIndexPath: IndexPath
//
//        if let indexPath = coordinator.destinationIndexPath {
//            destinationIndexPath = indexPath
//        } else {
//            // get from last row
//            let section = tableView.numberOfSections - 1
//            let row = tableView.numberOfRows(inSection: section)
//            destinationIndexPath = IndexPath(row: row, section: section)
//        }
//
//        let rowInd = destinationIndexPath.row
//
//        let group = DispatchGroup()
//
//        var postDescription = String()
//        group.enter()
//        coordinator.session.loadObjects(ofClass: NSString.self) { objects in
//            let uStrings = objects as! [String]
//            for uString in uStrings {
//                postDescription = uString
//                break
//            }
//            group.leave()
//        }
//
//        var postImage = UIImage()
//        group.enter()
//        coordinator.session.loadObjects(ofClass: UIImage.self) { objects in
//            let uImages = objects as! [UIImage]
//            for uImage in uImages {
//                postImage = uImage
//                break
//            }
//            group.leave()
//        }
//
//        group.notify(queue: .main) {
//            // delete moved post if moved
//            if coordinator.proposal.operation == .move {
//                posts.remove(at: self.postDragAtIndex)
//            }
//            // insert new post
//            let newPost = Post(author: "New author", description: postDescription, image: postImage, likes: 0, views: 0)
//            posts.insert(newPost, at: rowInd)
//
//            tableView.reloadData()
//        }
//    }
//}



