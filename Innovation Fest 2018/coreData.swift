//
//  coreData.swift
//  Innovation Fest 2018
//
//  Created by Taha Mahmut Yazici on 15/01/2018.
//  Copyright © 2018 TH Productions. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(title: String, innovation: String, teamwork: String, enterp: String,inspiration: String)-> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Saved_marks", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(title, forKey: "title")
        manageObject.setValue(innovation, forKey: "innovation")
        manageObject.setValue(teamwork, forKey: "teamwork")
        manageObject.setValue(enterp, forKey: "enterp")
        manageObject.setValue(inspiration, forKey: "inspiration")
        
        
        do{
            try context.save()
            print("saved")
            return true
        } catch {
            return false
        }
    }
    
    class func fetchObject()-> [Saved_marks]?{
        let context = getContext()
        var saved_p:[Saved_marks]? = nil
        do{
            saved_p = try context.fetch(Saved_marks.fetchRequest())
            return saved_p
        } catch {
            return saved_p
        }
        
    }
    
    class func deleteObject(saved_p: Saved_marks) -> Bool{
        let context = getContext()
        context.delete(saved_p)
        do{
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    
}
