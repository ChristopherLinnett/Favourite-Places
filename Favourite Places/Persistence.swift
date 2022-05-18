//
//  Persistence.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newPlace = Place(context: viewContext)
            newPlace.place_title = "New Place"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Favourite_Places")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    ///Creates an empty new place and saves it to the main file
    func addPlace() {
        let newPlace = Place(context: PersistenceController.shared.container.viewContext)
            newPlace.place_title = " New Place"
            
            do {
                try PersistenceController.shared.container.viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
    
    
       ///creates a pre-populated place for prefill examples
       func customAddPlace(title: String, lat: Double, lon: Double, description: String, imageURL: String) {
           let newPlace = Place(context: PersistenceController.shared.container.viewContext)
           newPlace.place_title = title
           newPlace.place_latitude = lat
           newPlace.place_longitude = lon
           newPlace.place_description = description
           newPlace.place_image_URL = URL(string: imageURL)
           
           do {
               try PersistenceController.shared.container.viewContext.save()
           } catch {
               // Replace this implementation with code to handle the error appropriately.
               // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
               let nsError = error as NSError
               fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           }
       }
       
       func generateDefaultData(){
           customAddPlace(title: "Deans blue hole", lat: 23.1063, lon: -75.0087, description: "Dean's Blue Hole near Clarence Town on Long Island, Bahamas, is the world's deepest known 'blue hole'", imageURL: "https://lh3.ggpht.com/-JzWg6iaoXBQ/Uw3ZkyPKy0I/AAAAAAAAwXE/pss_2vyEycM/deans-blue-hole-9%25255B6%25255D.jpg")
           customAddPlace(title: "Uluru", lat: -25.3444, lon: 131.0369, description: "Uluru also known as Ayers Rock and officially gazetted as Uluru / Ayers Rock, is a large sandstone formation in the centre of Australia.", imageURL: "https://media.nationalgeographic.org/assets/photos/000/265/26527.jpg")
           customAddPlace(title: "London Bridge", lat: 51.5079, lon: -0.0877, description: "London Bridge is a bridge in London, England over the River Thames, between the City of London and Southwark", imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/London_Bridge_from_St_Olaf_Stairs.jpg/280px-London_Bridge_from_St_Olaf_Stairs.jpg")
       }
       
    
}
