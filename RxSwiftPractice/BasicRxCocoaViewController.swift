//
//  BasicRxCocoaViewController.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class BasicRxCocoaViewController: UIViewController {
    
    private let pickerView = UIPickerView()
    private let simpleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.backgroundColor = .lightGray
    }
    private let tableView = UITableView()
    private let simpleSwitch = UISwitch()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setPickerView()
        setTableView()
        setSwitch()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        [simpleLabel, pickerView, tableView, simpleSwitch].forEach {
            view.addSubview($0)
        }
        simpleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(30)
        }
        pickerView.snp.makeConstraints {
            $0.top.equalTo(simpleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(pickerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44 * 3)
        }
        simpleSwitch.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setPickerView() {
        let items = Observable.just([
            "영화",
            "애니메이션",
            "드라마",
            "기타"
        ])
        
        items
            .bind(to: pickerView.rx.itemTitles) { row, element in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .map { $0.description }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        
        items
            .bind(to: tableView.rx.items) { tableView, row, element in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setSwitch() {
        Observable.of(true)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        simpleSwitch.rx.isOn
            .map { $0 ? "스위치 On" : "스위치 Off" }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
