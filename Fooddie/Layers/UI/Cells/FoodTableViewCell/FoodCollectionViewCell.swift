//
//  FoodCollectionViewCell.swift
//  Fooddie
//
//  Created by Afsal on 25/12/2023.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var foodImageView: CacheableImageView!
  @IBOutlet var stepper: UIStepperController!
  
  internal var model: FoodItem? {
    didSet {
      guard let model = model else { return }
      titleLabel.text = model.name
      stepper.count = model.quantity
      guard let imageUrl = model.imageUrl, let url = URL(string: imageUrl) else { return }
      foodImageView.setUpLoader()
      foodImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFill)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupViews()
  }
  
  private func setupViews() {
    layer.cornerRadius = 12
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 3, height: 3)
    layer.shadowOpacity = 0.7
    layer.shadowRadius = 4.0
    clipsToBounds = false
  }
}
