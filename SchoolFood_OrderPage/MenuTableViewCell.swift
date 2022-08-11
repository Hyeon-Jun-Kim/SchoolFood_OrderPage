//
//  MenuTableViewCell.swift
//  SchoolFood_OrderPage
//
//  Created by 김현준 on 2022/08/11.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    let foodImageView = UIImageView()
    let foodNameLabel = UILabel()
    let foodPriceLabel = UILabel()
    let foodCountLabel = UILabel()
    let stepper = UIStepper()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodNameLabel)
        contentView.addSubview(foodPriceLabel)
        contentView.addSubview(foodCountLabel)
        contentView.addSubview(stepper)
        
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        foodPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        foodCountLabel.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            foodImageView.widthAnchor.constraint(equalToConstant: 80),
            foodImageView.heightAnchor.constraint(equalToConstant: 80),
            
            foodNameLabel.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor, constant: 10),
            foodNameLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 10),
            foodNameLabel.heightAnchor.constraint(equalToConstant: 30),
            foodNameLabel.widthAnchor.constraint(equalToConstant: 110),
            
            foodPriceLabel.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor, constant: -10),
            foodPriceLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 10),
            foodPriceLabel.heightAnchor.constraint(equalToConstant: 30),
            foodPriceLabel.widthAnchor.constraint(equalToConstant: 100),
            
            foodCountLabel.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor),
            foodCountLabel.leadingAnchor.constraint(equalTo: foodNameLabel.trailingAnchor, constant: 20),
            foodCountLabel.widthAnchor.constraint(equalToConstant: 30),
            
            stepper.centerYAnchor.constraint(equalTo: foodImageView.centerYAnchor),
            stepper.leadingAnchor.constraint(equalTo: foodCountLabel.trailingAnchor, constant: 20)
        ])
        
        foodImageView.contentMode = .scaleAspectFit
        foodNameLabel.font = UIFont.systemFont(ofSize: 18)
        foodPriceLabel.font = UIFont.systemFont(ofSize: 16)
        foodCountLabel.font = UIFont.systemFont(ofSize: 18)
        foodCountLabel.textAlignment = .center
        foodCountLabel.text = "0개"
        
        stepper.addTarget(self, action: #selector(didTapStepper(_:)), for: .valueChanged)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didTapStepper(_ sender: UIStepper){
        print(sender.value)
        foodCountLabel.text = String(Int(sender.value))+"개"
    }
}
