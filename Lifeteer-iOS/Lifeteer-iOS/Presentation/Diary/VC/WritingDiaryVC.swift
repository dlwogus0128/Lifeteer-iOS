//
//  WritingDiaryVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/04/03.
//

import UIKit

import SnapKit
import Then
    
final class WritingDiaryVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .backButtonWithTitle).then {
        $0.setTitle("일기 입력하기")
        $0.layer.applyShadow(alpha: 0.10, y: 10, blur: 21)
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - Layout Helpers

extension WritingDiaryVC {
    private func setUI() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .mainBackground
    }
    
    private func setLayout() {
        view.addSubviews(naviBar)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(98)
        }
    }
}
