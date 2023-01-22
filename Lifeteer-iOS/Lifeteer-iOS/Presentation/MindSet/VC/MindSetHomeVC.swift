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
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .menuButtonWithBI).then {
        $0.layer.applyShadow(alpha: 0.10, y: 10, blur: 21)
    }
    private let monthLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .b1
        $0.text = "2023년 1월"
    }
    private var mindSetCalendar: FSCalendar! = FSCalendar(frame: .zero)
    private let todayMindSetLabel = UILabel().then {
        $0.text = "오늘의 마음짓기"
        $0.font = .h1
        $0.textColor = .mainBlack
    }
    
    private let viewHistoryButton = CustomButton(title: "기록 보기", type: .borderWithoutBGC)
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
        let attributedString = NSMutableAttributedString(string: $0.text, attributes: [.font: UIFont.h1, .foregroundColor: UIColor.mainBlack.withAlphaComponent(0.8)])
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
    
    let answerTextView = UITextView().then {
        $0.font = .b1
        $0.tintColor = .mainBlack.withAlphaComponent(0.8)
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 35, right: 16)
        $0.layer.cornerRadius = 20
    }
    
    private let saveButton = CustomButton(title: "마음짓기 저장하기", type: .fillWithGreen)

    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        setUI()
        setCalendar()
        setLayout()
        setDelegate()
        setDataSource()
        register()
    }
}

// MARK: - Methods

extension MindSetHomeVC {
    
    private func setDelegate() {
        mindSetCalendar.delegate = self
    }
    
    private func setDataSource() {
        mindSetCalendar.dataSource = self
    }
    
    private func register() {
        mindSetCalendar.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: - UI & Layout

extension MindSetHomeVC {
    private func setUI() {
        self.view.backgroundColor = .mainBackground
        self.writeMindSetContainer.backgroundColor = .mainBackground
        self.horizontalDividingLine.backgroundColor = .disabledFill
        self.answerTextView.backgroundColor = .disabledFill.withAlphaComponent(0.8)
    }
    
    private func setCalendar() {
        mindSetCalendar.do {
            $0.scope = .week
            $0.calendarHeaderView.isHidden = false
            $0.scrollEnabled = false
            $0.headerHeight = 0
            
            $0.appearance.todaySelectionColor = .none
            $0.appearance.todayColor = .none
            $0.appearance.titleTodayColor = .mainBlack.withAlphaComponent(0.8)
            
            $0.weekdayHeight = 18
            $0.calendarWeekdayView.fs_height = 0
            
            $0.appearance.selectionColor = .mainGreen.withAlphaComponent(0.2)
            $0.appearance.titleFont = .b0
            $0.appearance.weekdayFont = .b3
            $0.appearance.weekdayTextColor = .disabledText
            $0.appearance.titleDefaultColor = .mainBlack.withAlphaComponent(0.8)
            $0.appearance.borderRadius = 0.2.adjusted
        }
    }

    private func setLayout() {
        view.addSubviews(naviBar, monthLabel, mindSetCalendar,
                         todayMindSetLabel, viewHistoryButton, writeMindSetContainer, saveButton)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(98)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        mindSetCalendar.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(14)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(250)
        }
        
        viewHistoryButton.snp.makeConstraints { make in
            make.top.equalTo(mindSetCalendar.snp.bottom).offset(58)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(98)
            make.height.equalTo(27)
        }
        
        todayMindSetLabel.snp.makeConstraints { make in
            make.centerY.equalTo(viewHistoryButton.snp.centerY)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        writeMindSetContainer.snp.makeConstraints { make in
            make.top.equalTo(viewHistoryButton.snp.bottom).offset(19)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(303)
        }
        
        writeMindSetContainer.addSubviews(questionNumberLabel, horizontalDividingLine,
                                          selectedDateLabel, questionNumberLabel,questionTextView,answerTextView)
        
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
            make.top.equalTo(horizontalDividingLine.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            //make.height.equalTo(53)
        }
        
        answerTextView.snp.makeConstraints { make in
            make.top.equalTo(questionTextView.snp.bottom).offset(32)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(writeMindSetContainer.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(48)
        }
    }
}

extension MindSetHomeVC {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { make in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
        
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
        cell.fs_height = 50
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .mainBlack.withAlphaComponent(0.8)
    }
    
}
