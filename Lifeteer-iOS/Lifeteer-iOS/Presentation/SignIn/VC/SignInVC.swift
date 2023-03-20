//
//  SignInVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/03/20.
//

import UIKit

import Then
import SnapKit

final class SignInVC: UIViewController {
    
    // MARK: - UI Components
    private let logoImageView = UIImageView().then {
        $0.image = ImageLiterals.icMindsetBI
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "마음을 정리하는 시간,"
        $0.font = .b1
        $0.textColor = .mainGreen
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "마음짓기"
        $0.font = .h0
        $0.textColor = .mainGreen
    }
    
    private lazy var kakaoLoginButton = UIButton(type: .system).then {
        $0.setTitle("카카오톡으로 시작하기", for: .normal)
        $0.titleLabel?.font = .h6
        $0.setTitleColor(.mainBlack, for: .normal)
        $0.setBackgroundColor(UIColor(hex: "FEE600"), for: .normal)
        $0.layer.cornerRadius = 7
        $0.addTarget(self, action: #selector(touchUpKakaoLoginButton), for: .touchUpInside)
    }
    
    private let appleLoginButton = UIButton(type: .system).then {
        $0.setTitle("Apple로 시작하기", for: .normal)
        $0.titleLabel?.font = .h6
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.mainBlack, for: .normal)
        $0.layer.cornerRadius = 7
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - @objc Methods

extension SignInVC {
    @objc func touchUpKakaoLoginButton() {
        pushToSignInKaKaoDetailVC()
    }
}

// MARK: - Methods

extension SignInVC {
    private func pushToSignInKaKaoDetailVC() {
        let signInKaKaoDetailVC = SignInKaKaoDetailVC()
        signInKaKaoDetailVC.modalPresentationStyle = .overFullScreen
        self.present(signInKaKaoDetailVC, animated: false)
    }
}

// MARK: - UI & Layout

extension SignInVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(logoImageView, subTitleLabel, titleLabel, appleLoginButton, kakaoLoginButton)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(159)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(136)
            make.height.equalTo(logoImageView.snp.width).multipliedBy(0.7)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
}
