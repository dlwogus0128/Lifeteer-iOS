//
//  MindSetHomeVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import UIKit

import SnapKit
import Then
import FSCalendar

final class MindSetHomeVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // MARK: - Properties
    var height = 47
    var selectedDate: Date = Date()
    let textViewPlaceholder = "마음을 입력해주세요."
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .onlyBI).then {
        $0.layer.applyShadow(alpha: 0.10, y: 10, blur: 21)
    }
    
    private let todayMindSetLabel = UILabel().then {
        $0.text = "오늘의 마음짓기"
        $0.font = .h0
        $0.textColor = .mainBlack
    }
    
    private let basketImageView = UIImageView().then {
        $0.image = ImageLiterals.icBasket
    }
    
    private let helloUserLabel = UILabel().then {
        $0.text = "귀여운라이언 님, 활기찬 아침입니다!"
        $0.font = .h6
        $0.textColor = .mainBlack
    }
    
    private let suggestMindSetLabel = UILabel().then {
        $0.text = "오늘의 마음을 지어보세요."
        $0.font = .b2
        $0.textColor = .mainGreen
    }
    
    private let writeMindSetContainer = UIView().then {
        $0.layer.cornerRadius = 20
        $0.layer.applyShadow(alpha: 0.10, y: 10, blur: 21)
    }
    
    private let questionNumberLabel = UILabel().then {
        $0.text = "Q4"
        $0.font = .h0
        $0.textColor = .mainBlack.withAlphaComponent(0.8)
    }
    
    private let horizontalDividingLine = UIView()
    private lazy var questionTextView = UITextView().then {
        $0.text = "혹시 닉네임(별명)이 있나요? \n있다면, 그것의 의미는 무엇인가요?"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let attributedString = NSMutableAttributedString(string: $0.text, attributes: [.font: UIFont.h1, .foregroundColor: UIColor.mainBlack])
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        $0.attributedText = attributedString
        $0.isScrollEnabled = false
        $0.sizeToFit()
        $0.isEditable = false
    }
    
    private let selectedDateLabel = UILabel().then {
        $0.text = "2023.03.09"
        $0.font = .b2
        $0.textColor = .disabledText
    }
    
    private lazy var answerTextView = UITextView().then {
        $0.font = .b1
        $0.tintColor = UIColor(hex: "F4F4F4")
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 35, right: 16)
        $0.layer.cornerRadius = 20
        $0.text = self.textViewPlaceholder
        $0.textColor = .disabledText
        $0.delegate = self
    }
    
    private let saveButton = CustomButton(title: "마음짓기 저장하기", type: .fillWithGreen)
    
    private let cantFixMindSetGuideLabel = UILabel().then {
        $0.text = "마음짓기를 저장하면 수정이 불가해요. 신중하게 적어주세요."
        $0.font = .b3
        $0.textColor = .mainGreen
    }

    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        setUI()
        setLayout()
    }
}

// MARK: - @objc Function

extension MindSetHomeVC {
    
}

// MARK: - Methods

extension MindSetHomeVC {
    
}

// MARK: - UI & Layout

extension MindSetHomeVC {
    private func setUI() {
        self.view.backgroundColor = .mainBackground
        self.writeMindSetContainer.backgroundColor = .mainBackground
        self.horizontalDividingLine.backgroundColor = .disabledFill
        self.answerTextView.backgroundColor = .disabledFill.withAlphaComponent(0.8)
    }

    private func setLayout() {
        view.addSubviews(naviBar, todayMindSetLabel, basketImageView, helloUserLabel,
                         suggestMindSetLabel, writeMindSetContainer, saveButton,
                         cantFixMindSetGuideLabel)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(98)
        }

        todayMindSetLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(23)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        basketImageView.snp.makeConstraints { make in
            make.top.equalTo(todayMindSetLabel.snp.bottom).offset(20)
            make.leading.equalTo(todayMindSetLabel.snp.leading)
            make.width.height.equalTo(48)
        }
        
        helloUserLabel.snp.makeConstraints { make in
            make.top.equalTo(basketImageView.snp.top).inset(2)
            make.leading.equalTo(basketImageView.snp.trailing).offset(20)
        }
        
        suggestMindSetLabel.snp.makeConstraints { make in
            make.bottom.equalTo(basketImageView.snp.bottom).inset(3)
            make.leading.equalTo(helloUserLabel.snp.leading)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(110)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
        
        cantFixMindSetGuideLabel.snp.makeConstraints { make in
            make.bottom.equalTo(saveButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        writeMindSetContainer.snp.makeConstraints { make in
            make.top.equalTo(basketImageView.snp.bottom).offset(19)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(cantFixMindSetGuideLabel.snp.top).offset(-26)
        }
        
        setMindSetContentLayout()
    }
    
    private func setMindSetContentLayout() {
        writeMindSetContainer.addSubviews(questionNumberLabel, horizontalDividingLine,
                                          selectedDateLabel, questionNumberLabel, questionTextView, answerTextView)
        
        questionNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        horizontalDividingLine.snp.makeConstraints { make in
            make.top.equalTo(questionNumberLabel.snp.bottom).offset(5)
            make.leading.equalTo(questionNumberLabel.snp.leading)
            make.width.equalTo(104)
            make.height.equalTo(1)
        }
        
        selectedDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().inset(16)
        }
        
        questionTextView.snp.makeConstraints { make in
            make.top.equalTo(horizontalDividingLine.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        answerTextView.snp.makeConstraints { make in
            make.top.equalTo(questionTextView.snp.bottom).offset(25)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}

// MARK: - UITextViewDelegate

extension MindSetHomeVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .mainBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .disabledText
        }
    }
}
