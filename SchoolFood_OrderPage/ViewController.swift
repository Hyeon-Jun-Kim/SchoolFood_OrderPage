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
    let resetButton = UIButton(type: .system)
    
    let foodData = [["bibimbap","불맛 중화비빔밥","8500"],
                    ["jjolmyeon","어간장 육감쫄면","8000"],
                    ["specailmari","스페셜 마리","7500"],
                    ["tteokbokki","의성 마늘떡볶이","9000"]]
    
    override func viewDidLoad() {
        
        navigationLogoImageView.image = UIImage(named: "logo")
        navigationItem.titleView = navigationLogoImageView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "결제", style: .plain, target: self, action: #selector(didTapBarButtonItem(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "충전", style: .plain, target: self, action: #selector(didTapBarButtonItem(_:)))
        
        view.addSubview(foodTableView)
        view.addSubview(resetButton)
        
        foodTableView.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            foodTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            foodTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 900),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        foodTableView.separatorStyle = .none
        foodTableView.isScrollEnabled = false
        foodTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "Cell")
        foodTableView.dataSource = self
        
        resetButton.backgroundColor = .clear
        resetButton.setTitle("초기화", for: .normal)
        resetButton.setTitleColor(.red, for: .normal)
        
        super.viewDidLoad()
    }
    
    @objc
    func didTapBarButtonItem(_ sender: UIBarButtonItem){
        
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
        cell.foodPriceLabel.text = foodData[indexPath.row][2]
        cell.selectionStyle = .none
        
        return cell
    }
    
}

