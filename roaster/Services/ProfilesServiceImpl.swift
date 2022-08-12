//
//  ProfilesServiceImpl.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import Foundation
import CoreData
import Combine

class ProfilesServiceImpl: ProfilesService {
    
    static let shared = ProfilesServiceImpl()
    
    private let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService = CoreDataServiceImpl.shared) {
        self.coreDataService = coreDataService
    }
    
    func getProfiles() -> AnyPublisher<[Profile], Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                let request = CoreProfile.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "created", ascending: false)]
                let items = try self.coreDataService.context.fetch(request)
                promise(.success(items.map { item in
                    Profile(id: item.id, created: item.created, name: item.name ?? "",
                            startTemperature: Int(item.startTemperature), roastTime: Int(item.roastTime), weight: Int(item.weight))
                }))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func createProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                let item = CoreProfile(context: self.coreDataService.context)
                item.id = UUID().uuidString
                item.created = Date()
                item.name = profile.name
                item.startTemperature = Int16(profile.startTemperature)
                item.roastTime = Int16(profile.roastTime)
                item.weight = Int16(profile.weight)
                try self.coreDataService.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                if let id = profile.id {
                    let request = CoreProfile.fetchRequest()
                    request.predicate = NSPredicate(format: "id=%@", id)
                    let item = try self.coreDataService.context.fetch(request).first
                    if let item = item {
                        item.name = profile.name
                        item.startTemperature = Int16(profile.startTemperature)
                        item.roastTime = Int16(profile.roastTime)
                        item.weight = Int16(profile.weight)
                        try self.coreDataService.context.save()
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func deleteProfile(_ profile: Profile) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                if let id = profile.id {
                    let request = CoreProfile.fetchRequest()
                    request.predicate = NSPredicate(format: "id=%@", id)
                    let items = try self.coreDataService.context.fetch(request)
                    for item in items {
                        self.coreDataService.context.delete(item)
                    }
                    try self.coreDataService.context.save()
                    promise(.success(()))
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
