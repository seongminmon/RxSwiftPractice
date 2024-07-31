//
//  SimpleTableViewController.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class SimpleTableViewController: UIViewController {
    
    private let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private let disposeBag = DisposeBag()
    
    private let items = Observable.just((0..<20).map { "\($0)" })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setTableView()
    }
    
    private func configureView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setTableView() {
        items
            .bind(to: tableView.rx.items(
                cellIdentifier: "Cell",
                cellType: UITableViewCell.self)
            ) { row, element, cell in
                cell.accessoryType = .detailButton
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe { value in
                self.presentAlert("Tapped \(value)")
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped
            .subscribe { indexPath in
                self.presentAlert("Tapped Detail \(indexPath)")
            }
            .disposed(by: disposeBag)
    }
    
    private func presentAlert(_ title: String) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        let confirm = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
}
