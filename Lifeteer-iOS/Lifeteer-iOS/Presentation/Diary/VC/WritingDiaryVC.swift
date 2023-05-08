//
//  WritingDiaryVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/04/03.
//

import UIKit

import SnapKit
import Then
import FSCalendar
    
final class WritingDiaryVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // MARK: - Properties
    
    var currentDate: String = LTTimeFormatter.getCurrentMonthToString()
    private let diaryTitleMaxLength: Int = 39
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .backButtonWithTitle).then {
        $0.setTitle("일기 입력하기")
        $0.layer.applyShadow(alpha: 0.10, y: 10, blur: 21)
    }
    
    private let contentScrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var monthLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .b1
        $0.text = self.currentDate
    }
    
    var diaryCalendar: FSCalendar! = FSCalendar(frame: .zero)
        
    private let diaryTitleLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .h1
        $0.text = "일기 제목"
    }
    
    private let diaryTitleTextField = UITextField().then {
        $0.resignFirstResponder()
        $0.text = nil
        $0.textColor = .mainBlack
        $0.font = .b2
        $0.textAlignment = .left
        $0.attributedPlaceholder = NSAttributedString(
            string: "일기 제목을 작성해주세요.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.disabledText, NSAttributedString.Key.font: UIFont.b3]
        )
        $0.keyboardType = .webSearch
    }
    
    private let diaryTitleLine = UIView()
    
    private let titleCountByteLabel = UILabel().then {
        $0.text = "0 / 40 byte"
        $0.font = .b3
        $0.textColor = .disabledText
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCalendar()
        setLayout()
        setDelegate()
        setDataSource()
        register()
        setAddTarget()
    }
}

// MARK: - @objc Function

extension WritingDiaryVC {
    @objc private func textFieldTextDidChange() {
        guard let text = diaryTitleTextField.text else { return }
                
        if text.count > diaryTitleMaxLength {
            let index = text.index(text.startIndex, offsetBy: diaryTitleMaxLength)
            let newString = text[text.startIndex..<index]
            self.diaryTitleTextField.text = String(newString)
        }
    }
}

// MARK: - Methods

extension WritingDiaryVC {
    private func setDelegate() {
        diaryCalendar.delegate = self
        diaryTitleTextField.delegate = self
    }

    private func setDataSource() {
        diaryCalendar.dataSource = self
    }

    private func register() {
        diaryCalendar.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setAddTarget() {
        diaryTitleTextField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
    }
}

// MARK: - Layout Helpers

extension WritingDiaryVC {
    private func setUI() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .mainBackground
        diaryTitleLine.backgroundColor = .mainGreen
    }
    
    private func setCalendar() {
        diaryCalendar.do {
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
        view.addSubviews(naviBar, contentScrollView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(98)
        }
        
        contentScrollView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }

        contentScrollView.addSubviews(monthLabel, diaryCalendar)
        
        monthLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }

        diaryCalendar.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
            make.bottom.equalToSuperview()
        }
        
        setDiaryTitleLayout()
    }
    
    private func setDiaryTitleLayout() {
        contentScrollView.addSubviews(diaryTitleLabel, diaryTitleTextField, diaryTitleLine, titleCountByteLabel)
        
        diaryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(180)
            make.leading.equalToSuperview().offset(20)
        }
        
        diaryTitleTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.top.equalTo(diaryTitleLabel.snp.bottom).offset(24)
        }
        
        diaryTitleLine.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(diaryTitleTextField.snp.bottom).offset(10)
            make.height.equalTo(1)
        }
        
        titleCountByteLabel.snp.makeConstraints { make in
            make.top.equalTo(diaryTitleLine.snp.bottom).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

// MARK: - FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance
    
extension WritingDiaryVC {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
        return cell
    }
        
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .mainBlack.withAlphaComponent(0.8)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 200, height: 300)
//    }
}

// MARK: - UITextFieldDelegate

extension WritingDiaryVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let numberOfChars = newText.count
        titleCountByteLabel.text = "\(numberOfChars) / 40 byte"
        return true
    }
}
