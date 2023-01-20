//
//  MindSetHomeVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import UIKit

import SnapKit
import Then

final class MindSetHomeVC: UIViewController {

    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .menuButtonWithBI)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension MindSetHomeVC {
    private func setUI() {
        view.backgroundColor = .mainBackground
    }

    private func setLayout() {
        view.addSubviews(naviBar)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
