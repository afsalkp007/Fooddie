//
//  FoodViewModel.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023.
//

import Foundation

final class FoodViewModel {
  let multipeerService: MultiPeer
  let apiService: APIServiceProtocol
  
  var foodItems: [FoodItem]!
  var capturedItems = [CapturedMeal]()
  var updateUI: (([FoodItem]) -> Void)?
  
  init(multipeer: MultiPeer,
       apiService: APIServiceProtocol = APIService()) {
    self.multipeerService = multipeer
    self.apiService = apiService
    
    fetchItems()
  }
  
  private func fetchItems() {
    apiService.fetchFoodItems { [weak self] result in
      switch result {
      case let .success(response):
        guard let items = response?.foodItems else { return }
        self?.foodItems = items
        self?.updateUI?(items)
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
  
  internal func viewWillDisappear() {
    multipeerService.end()
  }
  
  internal func setupConnectivity() {
    multipeerService.initialize(serviceType: "fooddie-mpc")
    multipeerService.autoConnect()
  }
  
  internal func send(_ value: CGFloat, at index: Int) {
    foodItems = getUpdatedFoodItems(for: value, at: index)
    multipeerService.send(foodItems)
  }
  
  private func getUpdatedFoodItems(for value: CGFloat, at place: Int) -> [FoodItem] {
    return foodItems.enumerated().map { index, item in
      var newItem = item
      if place == index {
        newItem.quantity = value
      }
      return newItem
    }
  }
}