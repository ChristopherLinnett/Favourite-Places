//
//  ContentView.swift
//  Favourite Places
//
//  Created by Christopher Linnett on 9/5/2022.
//

import SwiftUI
import CoreData
///Master view, will show a title and a list of places. Each displaying a thumbnail and title that acts as a link to further details.
struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let persistenceController: PersistenceController
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.place_title, ascending: true)],
        animation: .default)
    private var places: FetchedResults<Place>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(places) { place in
                    NavigationLink {
                        PlaceView(place: place)
                            .navigationBarItems(trailing: EditButton())
                    } label: {
                        PlaceRowView(place: place)
                    }
                }
                .onDelete(perform: deletePlaces)
            }
            .navigationTitle("Favourite Places")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: persistenceController.addPlace) {
                        Label("Add Place", systemImage: "plus")
                    }
                }
            }
        }.onAppear {
            if places.isEmpty {
                persistenceController.generateDefaultData()
            }
        }
    }

    
    ///Deletes the selected place from the screen then saves that change
    private func deletePlaces(offsets: IndexSet) {
        withAnimation {
            offsets.map { places[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

