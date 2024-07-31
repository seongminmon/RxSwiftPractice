//
//  SimpleValidationViewController.swift
//  RxSwiftPractice
//
//  Created by 김성민 on 7/31/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

final class SimpleValidationViewController : UIViewController {
    
    private let usernameTextField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    private lazy var usernameValidLabel = UILabel().then {
        $0.text = "아이디: \(minimalUsernameLength)글자 이상 설정해주세요."
        $0.textColor = .systemRed
    }
    private let passwordTextField = UITextField().then {
        $0.borderStyle = .roundedRect
    }
    private lazy var passwordValidLabel = UILabel().then {
        $0.text = "패스워드: \(minimalPasswordLength)글자 이상 설정해주세요."
        $0.textColor = .systemRed
    }
    private let signupButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemPink
    }
    
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        [usernameTextField, 
         usernameValidLabel,
         passwordTextField,
         passwordValidLabel,
         signupButton].forEach {
            view.addSubview($0)
        }
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        usernameValidLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameValidLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        passwordValidLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        signupButton.snp.makeConstraints {
            $0.top.equalTo(passwordValidLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    private func setValidation() {
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signupButton.rx.tap
            .subscribe { [weak self] _ in
                self?.presentAlert("로그인 성공")
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
