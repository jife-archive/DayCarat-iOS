//
//  OnBoardingViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

final class OnBoardingViewController: BaseViewController {
    
    private let viewModel: OnBoardingViewModel
    
    private let pageControl = CustomPageControlView(numberOfPages: 3, width: 87, height: 2, spacing: 4, different: false)
    
    private let onBoardingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(OnBoardingCollectionViewCell.self,
                    forCellWithReuseIdentifier: OnBoardingCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .red
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let jumpBtn = DayCaratBtn(type: .Jump, text: "건너뛰기")
    private let nextBtn = DayCaratBtn(type: .Default, text: "다음으로")
    private let btnSV = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
    }
    
    init(viewModel: OnBoardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        jumpBtn.isHidden = true
        onBoardingCollectionView.delegate = self
    }
    
    override func addView() {
        [nextBtn, jumpBtn].forEach {
            self.btnSV.addArrangedSubview($0)
        }
        [pageControl, onBoardingCollectionView, btnSV].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        pageControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(3)
        }
        onBoardingCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(btnSV.snp.top).offset(-50)
        }
        btnSV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    override func binding() {
        
    }
}
extension OnBoardingViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: onBoardingCollectionView.contentOffset, size: onBoardingCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = onBoardingCollectionView.indexPathForItem(at: visiblePoint) {
            let currentIndex = indexPath.item
            
            UIView.animate(withDuration: 0.4) {
                if currentIndex == 2 {
                    self.jumpBtn.isHidden = false
                    self.jumpBtn.alpha = 1.0
                    
                } else {
                    self.jumpBtn.alpha = 0.5
                    self.jumpBtn.isHidden = true

                }
                self.pageControl.setCurrentPage(currentIndex)
            }
        }
    }
}

