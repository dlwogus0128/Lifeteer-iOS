//
//  DetailLandingPageVC.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/03/08.
//

import UIKit

import SnapKit
import Then

final class DetailLandingPageVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .backButton)
    private lazy var pageDataViewControllers: [UIViewController] = {
        return [FirstDetailLandingPageVC(), SecondDetailLandingPageVC(), ThirdDetailLandingPageVC(), LastDetailLandingPageVC()]
    }()
    private let detailLandingPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setFirstDetailLandingPageVC()
        setDelegate()
    }
}

// MARK: - Methods

extension DetailLandingPageVC {
    private func setFirstDetailLandingPageVC() {
        if let firstVC = pageDataViewControllers.first {
            detailLandingPageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setDelegate() {
        detailLandingPageViewController.delegate = self
        detailLandingPageViewController.dataSource = self
    }
}

// MARK: - UI & Layout

extension DetailLandingPageVC {
    private func setUI() {
        self.view.backgroundColor = .white
        self.detailLandingPageViewController.view.backgroundColor = .mainBlack
    }
    
    private func setLayout() {
        view.addSubview(naviBar)
        addChild(detailLandingPageViewController)
        view.addSubview(detailLandingPageViewController.view)
        
        naviBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        detailLandingPageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(66)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(165)
        }
        detailLandingPageViewController.didMove(toParent: self)
    }
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate

extension DetailLandingPageVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    /// 왼쪽에서 오른쪽으로 스와이프하기 직전에 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageDataViewControllers.firstIndex(of: viewController) else {return nil}
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return pageDataViewControllers[previousIndex]
    }
    
    /// 오른쪽에서 왼쪽으로 스와이프하기 직전에 호출
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageDataViewControllers.firstIndex(of: viewController) else {return nil}
        let nextIndex = index + 1
        if nextIndex == pageDataViewControllers.count {
            return nil
        }
        return pageDataViewControllers[nextIndex]
    }
}
