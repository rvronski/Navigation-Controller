//
//  CoreDataManager.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 08.01.2023.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init() {
        reloadLikes()
    }
    
    var likes: [Like] = {
        didSet {
            save()
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LikeData")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func reloadLikes() {
        let request = Like.fetchRequest()
        let likes = (try? persistentContainer.viewContext.fetch(request)) ?? []
        self.likes = likes
    }
    
    func createLike(authorText: String, descriptionText: String, likes: String, postImage: Data, views: String ) {
        let like = Like(context: persistentContainer.viewContext)
        like.likes = likes
        like.authorText = authorText
        like.postImage = postImage
        like.views = views
        like.descriptionText = descriptionText
        
        saveContext()
        reloadLikes()
    }
    
    func deleteLike(like: Like) {
        persistentContainer.viewContext.delete(like)
        saveContext()
        reloadLikes()
    }
    
    func save() {
        UserDefaults.standard.set(true, forKey: "isLike")
    }
}
