//
//  ViewController.swift
//  SchoolFood_OrderPage
//
//  Created by 김현준 on 2022/08/11.
//

import UIKit

class ViewController: UIViewController {
    
    let navigationLogoImageView = UIImageView()
    let foodTableView = UITableView()
    
    let foodData = [["bibimbap","8500","불맛 중화비빔밥"],
                    ["jjolmyeon","8000","어간장 육감쫄면"],
                    ["specailmari","7500","스페셜 마리"],
                    ["tteokbokki","9000","의성 마늘떡볶이"]]
    
    override func viewDidLoad() {
        
        navigationLogoImageView.image = UIImage(named: "logo")
        navigationItem.titleView = navigationLogoImageView
        
        view.addSubview(foodTableView)
        
        foodTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            foodTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            foodTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 900)
        ])
        
        foodTableView.separatorStyle = .none
        foodTableView.isScrollEnabled = false
        foodTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "Cell")
        foodTableView.dataSource = self
        
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                as? MenuTableViewCell else{ fatalError() }
        cell.foodImageView.image = UIImage(named: foodData[indexPath.row][0])
        cell.foodNameLabel.text = foodData[indexPath.row][1]
//        cell.foodNameLabel.sizeThatFits(<#T##size: CGSize##CGSize#>)
        cell.foodPriceLabel.text = foodData[indexPath.row][2]
        return cell
    }
    
}

