//
//  SignInKaKaoDetailVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/03/20.
//

import UIKit

import Then
import SnapKit

final class SignInKaKaoDetailVC: UIViewController {
    
    // MARK: - UI Components
        
    private let kakaoSimpleLoginButton = UIButton(type: .system).then {
        $0.setTitle("카카오톡으로 간편 로그인", for: .normal)
        $0.titleLabel?.font = .h6
        $0.setTitleColor(.mainBlack, for: .normal)
        $0.setBackgroundColor(UIColor(hex: "FEE600"), for: .normal)
        $0.layer.cornerRadius = 7
    }
    
    private let kakaoOtherAccountLoginButton = UIButton(type: .system).then {
        $0.setTitle("다른 카카오 계정으로 로그인", for: .normal)
        $0.titleLabel?.font = .h6
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.clear, for: .normal)
        $0.layer.cornerRadius = 7
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    private lazy var closeButton = UIButton(type: .system).then {
        $0.setImage(ImageLiterals.icKakaoClose, for: .normal)
        $0.tintColor = UIColor.white
        $0.addTarget(self, action: #selector(touchUpCloseImageView), for: .touchUpInside)
    }
    
    private let loginLabel = UILabel().then {
        $0.text = "Login"
        $0.font = 
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()
        setLayout()
    }
}

// MARK: - @objc Methods

extension SignInKaKaoDetailVC {
    @objc private func popToPreviousVC() {
        self.dismiss(animated: false)
    }
}

// MARK: - Methods

extension SignInKaKaoDetailVC {
    @objc private func touchUpCloseImageView() {
        popToPreviousVC()
    }
}

// MARK: - UI & Layout

extension SignInKaKaoDetailVC {
    private func setUI() {
        view.backgroundColor = .black.withAlphaComponent(0.8)
    }
    
    private func setNavigationBar() {
    }
    
    private func setLayout() {
        view.addSubviews(closeButton, kakaoSimpleLoginButton, kakaoOtherAccountLoginButton)
        
        closeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(60)
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        kakaoOtherAccountLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(closeButton.snp.top).offset(-48)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        kakaoSimpleLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoOtherAccountLoginButton.snp.top).offset(-12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
    }
}
