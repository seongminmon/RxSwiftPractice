//
//  SimplePickerViewController.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class SimplePickerViewController: UIViewController {
    
    private let pickerView1 = UIPickerView()
    private let pickerView2 = UIPickerView()
    private let pickerView3 = UIPickerView()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setPickerView()
    }
    
    private func configureView() {
        [pickerView1, pickerView2, pickerView3].forEach {
            view.addSubview($0)
        }
        pickerView1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
//            $0.height.equalTo(50)
        }
        pickerView2.snp.makeConstraints {
            $0.top.equalTo(pickerView1.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        pickerView3.snp.makeConstraints {
            $0.top.equalTo(pickerView2.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func setPickerView() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe { models in
                print("pickerView1 selected: \(models)")
            }
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                return NSAttributedString(string: "\(item)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.cyan, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe { models in
                print("pickerView2 selected: \(models)")
            }
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.red, UIColor.green, UIColor.blue])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe { models in
                print("pickerView3 selected: \(models)")
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
