//
//  UserDeetsStore.swift
//  toastgo-go
//
//  Created by SAN on 10/15/21.
//

import Combine
import CoreData
import os

class UserDeetsStore: NSObject, ObservableObject {
	
	var userDetails = CurrentValueSubject<[UserDeets], Never>([])
	
	private let userdetailsFetchController: NSFetchedResultsController<UserDeets>
	
	static let shared: UserDeetsStore = UserDeetsStore()
	
	private override init() {
		
		userdetailsFetchController = NSFetchedResultsController(
			fetchRequest: UserDeets.Request.all.rawValue,
			managedObjectContext: PersistenceController.shared.container.viewContext,
			sectionNameKeyPath: nil, cacheName: nil
		)
		
		super.init()
		
		userdetailsFetchController.delegate = self
		
		do {
			try userdetailsFetchController.performFetch()
			userDetails.value = userdetailsFetchController.fetchedObjects ?? []
		} catch {
			NSLog("Error: could not fetch objects")
		}
	}
	
	func add(id: Int, image: String, bio: String, user: User) {
		let newUserDeets = UserDeets(context: PersistenceController.shared.container.viewContext)
		newUserDeets.setValue(id, forKey: "id")
		newUserDeets.setValue(image, forKey: "image")
		newUserDeets.setValue(bio, forKey: "bio")
		newUserDeets.setValue(user, forKey: "user")
		saveContext()
	}
	
	func delete(id: Int) {
		let fetchUserDetails: NSFetchRequest<UserDeets> = UserDeets.fetchRequest()
		
		do {
			print("Deleting user details")
			guard let hereItem = try PersistenceController.shared.container.viewContext.fetch(fetchUserDetails).first else { return }
			PersistenceController.shared.container.viewContext.delete(hereItem)
			saveContext()
			print("Successfully deleted user details")
		} catch {
			debugPrint(error)
		}
	}
	
	private func saveContext() {
		do {
			print("Saving context")
			try PersistenceController.shared.container.viewContext.save()
			print("Successfully saved context")
		} catch {
			print("ERROR: \(error as NSObject)")
		}
	}
}


extension UserDeetsStore: NSFetchedResultsControllerDelegate {
	public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		guard let userDetails = controller.fetchedObjects as? [UserDeets] else { return }
		print("Context has changed, reloading spacecrafts")
		self.userDetails.value = userDetails
	}
}
