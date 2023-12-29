//
//  OptionalAppData.swift
//  Fooddie
//
//  Created by Afsal Mohammed on 19/12/2023
//

import Foundation

@propertyWrapper
class BaseAppData<Value> {

  let type: AppDataType
  let settings: AppData
  let defaultValue: Value

  var wrappedValue: Value {
    get { decodeValue() ?? defaultValue }
    set { encodeValue(newValue) }
  }

  init(
    _ type: AppDataType,
    settings: AppData = .default,
    defaultValue: Value
  ) {
    self.type = type
    self.settings = settings
    self.defaultValue = defaultValue
  }

  func decodeValue() -> Value? {
    fatalError("Override in subclass")
  }

  func encodeValue(_ value: Value?) {
    fatalError("Override in subclass")
  }

  func clear() {
    settings.remove(type)
  }
}
