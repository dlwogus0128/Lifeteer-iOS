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
    
    private lazy var naviBar = CustomNavigationBar(self, type: .menuButtonWithBI)
    private let monthLabel = UILabel().then {
        $0.textColor = .mainBlack
        $0.font = .b1
        $0.text = "2023년 1월"
    }
    var mindSetCalendar: FSCalendar! = FSCalendar(frame: .zero)

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        view.addSubviews(naviBar, monthLabel, mindSetCalendar)
        
        naviBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(54)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(20)
            make.leading.equalTo(20)
        }
        
        mindSetCalendar.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(14)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(400)
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
        //cell.fs_height =
        //cell.fs_width = 50
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .mainBlack.withAlphaComponent(0.8)
    }
    
}
