//
//  DiaryMainVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import UIKit

import SnapKit
import Then
import FSCalendar

final class DiaryMainVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // MARK: - Properties
    
    var currentDate: String = LTTimeFormatter.getCurrentMonthToString()
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .onlyTitle).then {
        $0.setTitle("일기")
        $0.layer.applyShadow(alpha: 0.10, y: 10, blur: 21)
    }
    
    private lazy var monthLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .b1
        $0.text = self.currentDate
    }
    
    private let contentView = UIView()
    private let textBubbleImageView = UIImageView().then {
        $0.image = ImageLiterals.icTextBubble
    }
    private lazy var diarySuggestionLabel = UILabel().then {
        $0.text = "김안젤라님, 오늘 작성된 일기가 없어요!\n일기를 작성해볼까요?"
        $0.numberOfLines = 2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 8
        let attributedString = NSMutableAttributedString(string: $0.text!, attributes: [.font: UIFont.b2, .foregroundColor: UIColor.disabledText])
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        $0.attributedText = attributedString
        $0.sizeToFit()
    }
    
    private lazy var diaryAddButton = UIButton(type: .custom).then {
        $0.setImage(ImageLiterals.icAdd, for: .normal)
    }
    
    var diaryCalendar: FSCalendar! = FSCalendar(frame: .zero)

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        setDataSource()
        register()
        setCalendar()
    }
}

// MARK: - Methods

extension DiaryMainVC {
    private func setDelegate() {
        diaryCalendar.delegate = self
    }

    private func setDataSource() {
        diaryCalendar.dataSource = self
    }

    private func register() {
        diaryCalendar.register(FSCalendarCell.self, forCellReuseIdentifier: "Cell")
    }
}

// MARK: - Layout Helpers

extension DiaryMainVC {
    private func setUI() {
        view.backgroundColor = .mainBackground
        contentView.backgroundColor = .textbox
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
        view.addSubviews(naviBar, monthLabel, diaryCalendar, contentView, textBubbleImageView, diarySuggestionLabel, diaryAddButton)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(98)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        diaryCalendar.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(400)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(diaryCalendar.snp.bottom).offset(60)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(304)
        }
        
        textBubbleImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(90)
            make.centerX.equalToSuperview()
        }
        
        diarySuggestionLabel.snp.makeConstraints { make in
            make.top.equalTo(textBubbleImageView.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
        
        diaryAddButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
    
// MARK: - FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance
    
extension DiaryMainVC {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
            calendar.snp.updateConstraints { make in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }
        
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "Cell", for: date, at: position)
        // cell.fs_height =
        // cell.fs_width = 50
        return cell
    }
        
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .mainBlack.withAlphaComponent(0.8)
    }
}
