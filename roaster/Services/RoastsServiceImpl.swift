//
//  RoastsServiceImpl.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import Foundation
import CoreData
import Combine

class RoastsServiceImpl: RoastsService {
    
    static let shared = RoastsServiceImpl()
    
    private let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService = CoreDataServiceImpl.shared) {
        self.coreDataService = coreDataService
    }
    
    func getRoasts() -> AnyPublisher<[Roast], Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                let request = CoreRoast.fetchRequest()
                request.sortDescriptors = [NSSortDescriptor(key: "created", ascending: false)]
                let items = try self.coreDataService.context.fetch(request)
                promise(.success(items.map { item in
                    print(item.endWeight)
                    var temps = [Temp]()
                    if let temps_time = item.temps_time, let temps_temp = item.temps_temp {
                        for i in 0..<temps_time.count {
                            temps.append(Temp(time: Int(temps_time[i]), temp: Int(temps_temp[i])))
                        }
                    }
                    return Roast(id: item.id, created: item.created, name: item.name ?? "",
                                 startTemperature: Int(item.startTemperature), roastTime: Int(item.roastTime), startWeight: Int(item.startWeight),
                                 temps: temps, firstCrackTime: Int(item.firstCrackTime), secondCrackTime: Int(item.secondCrackTime), endTime: Int(item.endTime), endWeight: Int(item.endWeight))
                }))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func createRoast(_ roast: Roast) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                let item = CoreRoast(context: self.coreDataService.context)
                item.id = UUID().uuidString
                item.created = Date()
                self.setItem(item, roast)
                try self.coreDataService.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    private func setItem(_ item: CoreRoast, _ roast: Roast) {
        item.name = roast.name
        item.startTemperature = Int16(roast.startTemperature)
        item.roastTime = Int16(roast.roastTime)
        item.startWeight = Int16(roast.startWeight)
        item.temps_time = roast.temps.map { temp in
            Int16(temp.time)
        }
        item.temps_temp = roast.temps.map { temp in
            Int16(temp.temp)
        }
        if let firstCrackTime = roast.firstCrackTime {
            item.firstCrackTime = Int16(firstCrackTime)
        }
        if let secondCrackTime = roast.secondCrackTime {
            item.secondCrackTime = Int16(secondCrackTime)
        }
        item.endTime = Int16(roast.endTime)
        if let endWeight = roast.endWeight {
            item.endWeight = Int16(endWeight)
        }
    }

    func updateRoast(_ roast: Roast) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                if let id = roast.id {
                    let request = CoreRoast.fetchRequest()
                    request.predicate = NSPredicate(format: "id=%@", id)
                    let item = try self.coreDataService.context.fetch(request).first
                    if let item = item {
                        self.setItem(item, roast)
                        try self.coreDataService.context.save()
                        promise(.success(()))
                    }
                }
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func deleteRoast(_ roast: Roast) -> AnyPublisher<Void, Error> {
        Future { [weak self] promise in
            do {
                guard let self = self else { fatalError() }
                if let id = roast.id {
                    let request = CoreRoast.fetchRequest()
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
