//
//  AddingNumbersViewController.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class AddingNumbersViewController: UIViewController {
    
    private let number1 = UITextField().then {
        $0.backgroundColor = .lightGray
        $0.textAlignment = .center
    }
    private let number2 = UITextField().then {
        $0.backgroundColor = .lightGray
        $0.textAlignment = .center
    }
    private let number3 = UITextField().then {
        $0.backgroundColor = .lightGray
        $0.textAlignment = .center
    }
    private let result = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        Observable.combineLatest(
            number1.rx.text.orEmpty,
            number2.rx.text.orEmpty,
            number3.rx.text.orEmpty
        ) { text1, text2, text3 -> Int in
            return (Int(text1) ?? 0) + (Int(text2) ?? 0) + (Int(text3) ?? 0)
        }
        .map { "\($0)" }
        .bind(to: result.rx.text)
        .disposed(by: disposeBag)
    }
    
    private func configureView() {
        [number1, number2, number3, result].forEach {
            view.addSubview($0)
        }
        number1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        number2.snp.makeConstraints {
            $0.top.equalTo(number1.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        number3.snp.makeConstraints {
            $0.top.equalTo(number2.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        result.snp.makeConstraints {
            $0.top.equalTo(number3.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
}
