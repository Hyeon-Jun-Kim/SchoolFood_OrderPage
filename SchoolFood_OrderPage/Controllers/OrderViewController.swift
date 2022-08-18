//
//  ViewController.swift
//  SchoolFood_OrderPage
//
//  Created by 김현준 on 2022/08/11.
//

import UIKit

class OrderViewController: UIViewController {
    
    let navigationLogoImageView = UIImageView()
    let foodTableView = UITableView()
//    let paymentStackView = UIStackView()
    let walletLabel = UILabel()
    let walletValueLabel = UILabel()
    let priceLabel = UILabel()
    let priceValueLabel = UILabel()
    let resetButton = UIButton(type: .system)
    
    let foodData = [["bibimbap","불맛 중화비빔밥","8500"],
                    ["jjolmyeon","어간장 육감쫄면","8000"],
                    ["specailmari","스페셜 마리","7500"],
                    ["tteokbokki","의성 마늘떡볶이","9000"]]
    var cartData = [0, 0, 0, 0]
    
    var walletValue = 0 {
        willSet { walletValueLabel.text = "\(numFormatter(String(newValue)))원" }
    }
    lazy var priceValue = 0{
        willSet { priceValueLabel.text = "\(numFormatter(String(newValue)))원" }
    }
    
    override func viewDidLoad() {
        
        navigationLogoImageView.image = UIImage(named: "logo")
        navigationItem.titleView = navigationLogoImageView
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "결제", style: .plain, target: self, action: #selector(didTapBarButtonItem(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "충전", style: .plain, target: self, action: #selector(didTapBarButtonItem(_:)))
        
        view.addSubview(foodTableView)
        view.addSubview(walletLabel)
        view.addSubview(walletValueLabel)
        view.addSubview(priceLabel)
        view.addSubview(priceValueLabel)
        view.addSubview(resetButton)
        
        foodTableView.translatesAutoresizingMaskIntoConstraints = false
        walletLabel.translatesAutoresizingMaskIntoConstraints = false
        walletValueLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceValueLabel.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            foodTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            foodTableView.heightAnchor.constraint(equalToConstant: 400),
            
            walletLabel.topAnchor.constraint(equalTo: foodTableView.bottomAnchor, constant: 90),
            walletLabel.leadingAnchor.constraint(equalTo: foodTableView.centerXAnchor, constant: -50),
            walletLabel.widthAnchor.constraint(equalToConstant: 100),
            walletValueLabel.centerYAnchor.constraint(equalTo: walletLabel.centerYAnchor),
            walletValueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            priceLabel.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: walletLabel.centerXAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceValueLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            priceValueLabel.trailingAnchor.constraint(equalTo: walletValueLabel.trailingAnchor),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        foodTableView.separatorStyle = .none
        foodTableView.isScrollEnabled = false
        foodTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "Cell")
        foodTableView.dataSource = self
        
        setLabels("내 지갑", walletLabel, String(walletValue) + "원", walletValueLabel)
        setLabels("최종 결제금액", priceLabel, String(priceValue) + "원", priceValueLabel)
        
        resetButton.backgroundColor = .clear
        resetButton.setTitle("초기화", for: .normal)
        resetButton.setTitleColor(.red, for: .normal)
        resetButton.addTarget(self, action: #selector(didTapResetButton(_:)), for: .touchUpInside)
        
        super.viewDidLoad()
    }
    
    // [Mark] Navigation Bar Button 이벤트 분기 함수
    @objc
    func didTapBarButtonItem(_ sender: UIBarButtonItem){
        switch sender{
        case navigationItem.leftBarButtonItem:
            presntAlertController_Left()
        case navigationItem.rightBarButtonItem:
            presntAlertController_Right()
        default:
            fatalError()
        }
    }
    
    // [Mark] Reset Button 동작 함수
    @objc
    func didTapResetButton(_ sender: UIButton){
        walletValue = 0
        priceValue = 0
        cartData = [0, 0, 0, 0]
        foodTableView.reloadData()
    }
    
    // [Mark] 결제 관련 Labels 세팅 함수
    func setLabels(_ text1: String, _ label1: UILabel, _ text2: String, _ label2: UILabel){
        label1.text = text1
        label1.textAlignment = .right
        label1.font = UIFont.systemFont(ofSize: 16)
        
        label2.text = text2
        label2.font = UIFont.boldSystemFont(ofSize: 16)
        label2.textAlignment = .right
    }
    
    // [Mark] 금액에 쉼표 표시하는 함수
    func numFormatter(_ num: String) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if !(isStringEmptyCheck(num)), let price = Int(num){
            return numberFormatter.string(from: price as NSNumber)!
        }
        return ""
    }
     // [mark] String 값의 nil 여부 판단 함수
    func isStringEmptyCheck(_ str: String?) -> Bool{
        if str == nil{return true}
        else{return false}
    }
    
    // [Mark] Navigation Bar Left Button : 충전
    func presntAlertController_Left(){
        let alertController = UIAlertController(title: "지갑", message: "얼마를 충전할까요?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default){(_) in
            let insertVal = alertController.textFields?[0].text
            self.walletValue += Int(insertVal!) ?? 0
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        alertController.addTextField{ textField in
            textField.keyboardType = .numberPad
        }
        
        present(alertController, animated: true)
    }
    
    // [Mark] Navigation Bar Right Button : 결제
    func presntAlertController_Right(){
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        if priceValue == 0{
            alertController.title = "상품 없음"
            alertController.message = "먼저 상품을 추가하세요."
            let confirmAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(confirmAction)
        }else if priceValue > walletValue{
            alertController.title = "잔액 부족"
            alertController.message = String(priceValue - walletValue)+"원이 부족합니다."
            let confirmAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(confirmAction)
        }else {
            alertController.title = "결제"
            alertController.message = String(priceValue)+"원을 결제하시겠습니까?"
            let confirmAction = UIAlertAction(title: "확인", style: .default){(_) in
                self.walletValue = self.walletValue - self.priceValue
                self.priceValue = 0
                self.cartData = [0, 0, 0, 0]
                self.foodTableView.reloadData()
            }
            alertController.addAction(confirmAction)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            alertController.addAction(cancelAction)
        }
        present(alertController, animated: true)
    }
}

// [Mark] Table Data Sourse
extension OrderViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                as? MenuTableViewCell else{ fatalError() }
        cell.foodImageView.image = UIImage(named: foodData[indexPath.row][0])
        cell.foodNameLabel.text = foodData[indexPath.row][1]
        cell.foodPriceLabel.text = self.numFormatter(foodData[indexPath.row][2]) + "원"
        cell.foodCountLabel.text = numFormatter(String(cartData[indexPath.row]))
        cell.tag = indexPath.row
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

// [Mark] TableViewCell Delegate
extension OrderViewController: orderTableViewCellDelegate{
    func didtapStepper(count: Int, tag: Int) {
        cartData[tag] = count
        // 주문 음식 수의 총 가격을 계산 : 각 음식의 가격 * 카트에 담긴 수
        priceValue = 0
        for i in 0...3{
            let foodPrice = Int(foodData[i][2]) ?? 0
            priceValue += foodPrice * cartData[i]
        }
    }
}


