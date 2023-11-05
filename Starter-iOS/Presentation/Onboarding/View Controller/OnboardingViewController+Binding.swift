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
