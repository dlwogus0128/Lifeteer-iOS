//
//  StartLandingPageVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/03/07.
//

import UIKit

import SnapKit
import Then
import Lottie

final class StartLandingPageVC: UIViewController {
    
    // MARK: - UI Components
    private let titleLabel = UILabel().then {
        $0.text = "타인에게 나는, \n나에게 타인은 \n어떤 존재였나요?"
        $0.numberOfLines = 3
        let attrString = NSMutableAttributedString(string: $0.text!, attributes: [.font: UIFont.landingPageTitleFont, .foregroundColor: UIColor.mainBlack])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
    }
    
    private let searchIntoMindSetButton = CustomButton(title: "마음짓기 알아보기", type: .fillWithGreen)
    private let mainAnimationView: LottieAnimationView = .init(name: "StartLandingPageImage")

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAnimation()
        setAddTarget()
        setNavigationBar()
    }
}

// MARK: - Methods

extension StartLandingPageVC {
    private func setAddTarget() {
        self.searchIntoMindSetButton.addTarget(self, action: #selector(searchIntoMindSetButtonDidTap), for: .touchUpInside)
    }

    private func pushToDetailLandingPageVC() {
        let detailLandingPageVC = DetailLandingPageVC()
        self.navigationController?.pushViewController(detailLandingPageVC, animated: true)
    }
    
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - @objc Function

extension StartLandingPageVC {
    @objc
    private func searchIntoMindSetButtonDidTap() {
        pushToDetailLandingPageVC()
    }
}

// MARK: - UI & Layout

extension StartLandingPageVC {
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(titleLabel, mainAnimationView, searchIntoMindSetButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(113)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(26)
        }
        
        searchIntoMindSetButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
        
        mainAnimationView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(-100)
            make.height.equalTo(mainAnimationView.snp.width).multipliedBy(0.8)
        }
    }
    
    private func setAnimation() {
        mainAnimationView.play()
        mainAnimationView.loopMode = .loop
    }
}
