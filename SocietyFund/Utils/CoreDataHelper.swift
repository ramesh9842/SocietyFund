//
//  CoreDataHelper.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import CoreData
import UIKit

enum SaveContextType {
    case insert, update, delete
}

class CoreDataUtil {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    static let shared = CoreDataUtil()
    
    // MARK: - Core Data Saving support
    func saveContext (_ type: SaveContextType) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                Log.debug(msg: "Error in \(type) process. \(error.localizedDescription)")
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        } else {
            Log.debug(msg: "No uncommited changes.")
        }
        
    }
    
    // MARK: - Insert Feed Data
    
/*
    func insertFeedData(feeds: [Category]?) {
        var contentObjArray = [FeedContent]()
        guard let feeds = feeds else {
            return
        }
        for feed in feeds {
//            if let entityDesc = NSEntityDescription.entity(forEntityName: "FeedCategory", in: context){
//                let feed = NSManagedObject(entity: entityDesc, insertInto: context)
//            }
            contentObjArray.removeAll()
            let feedOb = FeedCategory(context: context)
            feedOb.title = feed.title
            feedOb.author = feed.author
            feedOb.pubDate = feed.pubDate
            feedOb.thumbnail = feed.thumbnail
            for content in feed.content! {
                let contentObj = FeedContent(context: context)
                contentObj.feedName = content.feedName
                contentObj.feedDesc = content.feedDesc
                contentObj.feedImage = content.feedImage
                contentObj.feedAddOrRemove = content.feedAddOrRemove!
                contentObjArray.append(contentObj)
            }
            feedOb.contents = NSSet.init(array: contentObjArray)
        }
        saveContext(.insert)
    }
 */
    
    // MARK: - FETCH DATA
/*
    func fetchFeed() -> [Category]? {
        var categoryArray = [Category]()
        var feedArray = [Feed]()
        var count = 0
        let fetchRequest = NSFetchRequest<FeedCategory>(entityName: "FeedCategory")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let feeds = try context.fetch(fetchRequest)
            for feed in feeds {
                feedArray.removeAll()
                let title = feed.title
                let author = feed.author
                let pubDate = feed.pubDate
                let thumbnail = feed.thumbnail
                for (content) in feed.contents as! Set<FeedContent> {
                    let feedName = content.feedName ?? ""
                    let feedDesc = content.feedDesc ?? ""
                    let feedImage = content.feedImage ?? ""
                    let feedAdded = content.feedAddOrRemove
                    let feed = Feed(feedImage: feedImage, feedName: feedName, feedDesc: feedDesc, feedAddOrRemove: feedAdded)
                    feedArray.append(feed)
                }
                let category = Category(title: title, author: author, pubDate: pubDate, thumbnail: thumbnail, content: feedArray)
                categoryArray.append(category)
            }
               return categoryArray
        }catch let error as NSError {
            Logger.log(description: "Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
*/
    
    // MARK: - UPDATE DATA
/*
    func updateFeedAddOrRemove(value: Bool) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>.init(entityName: "FeedCategory")
        fetchRequest.predicate = NSPredicate(format: "feedAddOrRemove = %@", value)
        do{
            let fetchResults = try context.fetch(fetchRequest)
            let objUpdate = fetchResults[0] as! NSManagedObject
            objUpdate.setValue(!value, forKey: "feedAddOrRemove")
            saveContext(.update)
        }catch {
        }
        
    }
 */
    
    // MARK: - DELETE DATA
/*
    func deleteFeedData(feeds: [Category]) {
        let fetchRequest = NSFetchRequest<FeedCategory>.init(entityName: "FeedCategory")
//        fetchRequest.predicate = NSPredicate(format: "status = %@", value)
        do{
            let feeds = try context.fetch(fetchRequest)
            for feed in feeds {
                context.delete(feed)
            }
            saveContext(.delete)
        }catch {
        }
    }
 */
    
}
