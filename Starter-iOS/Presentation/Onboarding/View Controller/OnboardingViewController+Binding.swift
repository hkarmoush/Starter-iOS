//
//  OnboardingViewController+Binding.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 05/11/2023.
//

import UIKit
import RxSwift

extension OnboardingViewController {
    
    func setupReactiveBindings() {
        bindCollectionViewToViewModel()
        bindPageControlToCurrentIndex()
        bindNextButton()
        setupViewSizeChangeSubscription()
        setupOrientationChangeSubscription()
    }
    
    private func bindCollectionViewToViewModel() {
        setupCollectionViewDataSource()
        setupCollectionViewScrollEventSubscription()
    }
    
    private func setupCollectionViewDataSource() {
        viewModel.pages
            .bind(to: collectionView.rx.items(cellIdentifier: OnboardingCollectionViewCell.identifier, cellType: OnboardingCollectionViewCell.self)) { _, model, cell in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindNextButton() {
        viewModel.currentIndex
            .asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] page in
                self?.updateButtonTitle(for: page)
            })
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] in
                self?.goToNextPage()
            }
            .disposed(by: disposeBag)
    }
    
    private func goToNextPage() {
        viewModel.currentIndex
            .take(1)
            .subscribe(onNext: { [weak self] currentPage in
                debugPrint("Current Page: \(currentPage)")
                
                let nextPage = currentPage + 1
                let isLastPage = nextPage >= (self?.viewModel.pagesCount ?? 0)
                
                debugPrint("Next Page: \(nextPage), Is Last Page: \(isLastPage)")
                
                if isLastPage {
                    self?.coordinatorDelegate?.didFinishOnboarding()
                    DIContainer.shared.resolve(AppLaunchStateManager.self)?.isFirstLaunch = false
                } else {
                    debugPrint("Setting current index to: \(nextPage)")
                    self?.viewModel.setCurrentIndex(to: nextPage)
                    DispatchQueue.main.async {
                        let offsetX = CGFloat(nextPage) * (self?.collectionView.frame.size.width)!
                        self?.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func updateButtonTitle(for page: Int) {
        let isLastPage = page == viewModel.pagesCount - 1
        nextButton.setTitle(isLastPage ? "Done" : "Next", for: .normal)
    }
    
    private func setupCollectionViewScrollEventSubscription() {
        collectionView.rx.didEndDecelerating
            .map { [unowned self] _ in self.calculateCurrentPageIndex() }
            .subscribe(onNext: viewModel.setCurrentIndex(to:))
            .disposed(by: disposeBag)
    }
    
    private func bindPageControlToCurrentIndex() {
        viewModel.currentIndex
            .observe(on: MainScheduler.instance)
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposeBag)
    }
    
    private func setupViewSizeChangeSubscription() {
        rx.viewDidLayoutSubviews
            .map { _ in self.view.bounds.size }
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] size in self.adjustCollectionViewLayout(to: size) })
            .disposed(by: disposeBag)
    }
    
    private func setupOrientationChangeSubscription() {
        NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification)
            .map { _ in self.view.bounds.size }
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] size in self.adjustCollectionViewLayout(to: size) })
            .disposed(by: disposeBag)
    }
    
    func calculateCurrentPageIndex() -> Int {
        let pageWidth = collectionView.frame.size.width
        return max(0, Int(collectionView.contentOffset.x / pageWidth))
    }
    
    func adjustCollectionViewLayout(to size: CGSize) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: size.width, height: size.height)
            layout.invalidateLayout()
        }
    }
}
