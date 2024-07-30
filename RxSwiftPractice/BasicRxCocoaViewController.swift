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
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setPickerView()
    }
    
    private func configureView() {
        [pickerView, simpleLabel].forEach {
            view.addSubview($0)
        }
        pickerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        simpleLabel.snp.makeConstraints {
            $0.top.equalTo(pickerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        view.backgroundColor = .white
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
}
