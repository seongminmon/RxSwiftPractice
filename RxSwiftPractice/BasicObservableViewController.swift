//
//  BasicObservableViewController.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa

final class BasicObservableViewController: UIViewController {
    
    let item1 = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
    let item2 = [2.3, 2.0, 1.3]
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        justExample()
        ofExample()
        fromExample()
        takeExample()
    }
    
    // 1. just - 하나의 값만 Emit
    private func justExample() {
        Observable.just(item1)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just - completed")
            } onDisposed: {
                print("just - disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 2. of - 2개 이상의 값을 Emit할 수 있음
    private func ofExample() {
        Observable.of(item1, item2)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of - completed")
            } onDisposed: {
                print("of - disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 3. from - 배열의 각 요소를 Emit
    private func fromExample() {
        Observable.from(item1)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from - completed")
            } onDisposed: {
                print("from - disposed")
            }
            .disposed(by: disposeBag)
    }
    
    // 4. take - 방출된 아이템 중 처음 n개의 아이템을 Emit
    private func takeExample() {
        Observable.repeatElement("haha")
            .take(5)
            .subscribe { value in
                print("take - \(value)")
            } onError: { error in
                print("take - \(error)")
            } onCompleted: {
                print("take - completed")
            } onDisposed: {
                print("take - disposed")
            }
            .disposed(by: disposeBag)
    }
}
