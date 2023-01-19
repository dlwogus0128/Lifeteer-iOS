//
//  TabBarController.swift
//  Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/01/19.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    private var upperLineView: UIView!
    private let spacing: CGFloat = 10
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setUI()
        setTabBarControllers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.addTabBarIndicatorView(index: 0, isFirstTime: true)
        }
    }
}

// MARK: - Methods

extension TabBarController {
    private func setUI() {
        tabBar.backgroundColor = .mainBackground
        tabBar.unselectedItemTintColor = .disabledText
        tabBar.tintColor = .mainGreen
    }
    
    private func setTabBarControllers() {
        let letterMainNVC = templateNavigationController(title: "편지",
                                                         unselectedImage: ImageLiterals.icLetter,
                                                         selectedImage: ImageLiterals.icLetterFill,
                                                         rootViewController: LetterMainVC())
        let recordedWillMainNVC = templateNavigationController(title: "음성유언",
                                                               unselectedImage: ImageLiterals.icRecordedWill,
                                                               selectedImage: ImageLiterals.icRecordedWillFill,
                                                               rootViewController: RecordedWillMainVC())
        let mindSetHomeNVC = templateNavigationController(title: "마음짓기",
                                                          unselectedImage: ImageLiterals.icMindset,
                                                          selectedImage: ImageLiterals.icMindsetFill,
                                                          rootViewController: MindSetHomeVC())
        let bucketListMainNVC = templateNavigationController(title: "버킷리스트",
                                                             unselectedImage: ImageLiterals.icBucketList,
                                                             selectedImage: ImageLiterals.icBucketListFill,
                                                             rootViewController: BucketListMainVC())
        let diaryMainNVC = templateNavigationController(title: "일기",
                                                        unselectedImage: ImageLiterals.icDiary,
                                                        selectedImage: ImageLiterals.icDiaryFill,
                                                        rootViewController: DiaryMainVC())
        
        viewControllers = [letterMainNVC, recordedWillMainNVC, mindSetHomeNVC, bucketListMainNVC, diaryMainNVC]
    }
    
    // Add tabbar item indicator upper line
    private func addTabBarIndicatorView(index: Int, isFirstTime: Bool = false) {
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else { return }
        if !isFirstTime {
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 2))
        upperLineView.backgroundColor = .mainGreen
        tabBar.addSubview(upperLineView)
    }
    
    private func templateNavigationController(title: String, unselectedImage: UIImage?, selectedImage: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.title = title
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.isHidden = true
        nav.tabBarItem.badgeColor = .yellow
        return nav
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabBarIndicatorView(index: self.selectedIndex)
    }
}
