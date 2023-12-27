//
//  APIService.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}

final class APIService: APIServiceProtocol {
  private let networking: Networking
  
  init(networking: Networking = NetworkService()) {
    self.networking = networking
  }
  
  /// Fetch food data
  /// - Parameter completion: Called when operation finishes
  /// https://yummie.glitch.me/dishes/cat1
  func fetchFoodItems(_ completion: @escaping (Result<FoodResponse?>) -> Void) {
    let resource = Resource(
      url: Constants.Urls.foddieUrl,
      path: "v3/5866141b-f9c5-4af6-aea2-d385343ae0be")
    _ = networking.fetch(resource: resource, completion: { data in
      DispatchQueue.main.async {
        completion(.success(data.flatMap({ FoodResponse.make(data: $0) }) ))
      }
    })
  }
}
