//
//  BasicButtonViewController.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class BasicButtonViewController: UIViewController {
    
    private let basicButton = UIButton().then {
        $0.setTitle("버튼", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    private let basicLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        firstExample()
    }
    
    private func configureView() {
        [basicLabel, basicButton].forEach {
            view.addSubview($0)
        }
        basicLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        basicButton.snp.makeConstraints {
            $0.top.equalTo(basicLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        view.backgroundColor = .white
        basicLabel.backgroundColor = .lightGray
        basicButton.backgroundColor = .systemPink
    }
    
    private func firstExample() {
        // 1. 기본형
//        basicButton.rx.tap
//            .subscribe { _ in
//                print("next")
//                self.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//            } onError: { _ in
//                print("error")
//            } onCompleted: {
//                print("complete")
//            } onDisposed: {
//                print("dispose")
//            }
//            .disposed(by: disposeBag)
        
        // 2. Infinite Observable Stream이라서 onError, onCompleted 생략 가능
//        basicButton.rx.tap
//            .subscribe { _ in
//                print("next")
//                self.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//            } onDisposed: {
//                print("dispose")
//            }
//            .disposed(by: disposeBag)
        
        // 3. 메모리 leak 대응 (1)
//        basicButton.rx.tap
//            .subscribe { [weak self] _ in
//                print("next")
//                self?.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//            } onDisposed: {
//                print("dispose")
//            }
//            .disposed(by: disposeBag)
        
        // 4. 메모리 leak 대응 (2)
//        basicButton.rx.tap
//            .withUnretained(self)
//            .subscribe { _ in
//                print("next")
//                self.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//            } onDisposed: {
//                print("dispose")
//            }
//            .disposed(by: disposeBag)
        
        // 5. 메모리 leak 대응 (3)
//        basicButton.rx.tap
//            .subscribe(with: self, onNext: { owner, _ in
//                print("next")
//                owner.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//            }, onDisposed: { owner in
//                print("dispose")
//            })
//            .disposed(by: disposeBag)
        
        // 6. UI 업데이트 메인쓰레드에서 처리하기 (1)
//        basicButton.rx.tap
//            .subscribe(with: self, onNext: { owner, _ in
//                print("next")
//                DispatchQueue.main.async {
//                    owner.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//                }
//            }, onDisposed: { owner in
//                print("dispose")
//            })
//            .disposed(by: disposeBag)
        
        // 7. UI 업데이트 메인쓰레드에서 처리하기 (2)
//        basicButton.rx.tap
//            .observe(on: MainScheduler.instance)
//            .subscribe(with: self, onNext: { owner, _ in
//                print("next")
//                owner.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//            }, onDisposed: { owner in
//                print("dispose")
//            })
//            .disposed(by: disposeBag)
        
        // 8. bind: next 이벤트만 받고, 메인쓰레드 보장하는 subscribe
//        basicButton.rx.tap
//            .bind(with: self) { owner, _ in
//                print("next")
//                owner.basicLabel.text = "\(Int.random(in: 1...100))번이 선택되었습니다."
//            }
//            .disposed(by: disposeBag)
        
        // 9. map과 bind(to:) 사용
        basicButton.rx.tap
            .map { "\(Int.random(in: 1...100))번이 선택되었습니다." }
            .bind(to: basicLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
