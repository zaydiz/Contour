//
//  ProjectsViewModel.swift
//  Shiny
//
//  Created by Anton Novoselov on 20.04.2021.
//

import Foundation
import CoreData
import SwiftUI

extension ProjectsView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        @State private var showingSortOrder = false
        var sortOrder = Item.SortOrder.optimized

        private let projectsController: NSFetchedResultsController<Project>
        @Published var projects = [Project]()
        
        let dataController: DataController
        
        let showClosedProjects: Bool
        
        @Published var showingUnlockView = false

        init(dataController: DataController, showClosedProjects: Bool) {
            self.dataController = dataController
            self.showClosedProjects = showClosedProjects

            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
            request.predicate = NSPredicate(format: "closed = %d", showClosedProjects)
            
            projectsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
            super.init()
            projectsController.delegate = self

            do {
                try projectsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch projects")
            }
        }
        
        func delete(_ offsets: IndexSet, from project: Project) {
            let allItems = project.projectItems(using: sortOrder)

            for offset in offsets {
                let item = allItems[offset]
                dataController.delete(item)
            }

            dataController.save()
        }
        
        func addProject() {
            if dataController.addProject() == false {
                showingUnlockView.toggle()
            }
        }

        func addItem(to project: Project) {
            let item = Item(context: dataController.container.viewContext)
            item.project = project
            item.creationDate = Date()
            item.priority = 2
            item.completed = false
            dataController.save()
        }
        
        // MARK: - NSFetchedResultsControllerDelegate
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newProjects = controller.fetchedObjects as? [Project] {
                self.projects = newProjects
            }
        }
    }
    
    
}
