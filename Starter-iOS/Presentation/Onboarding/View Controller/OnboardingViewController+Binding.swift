//
//  OnboardingViewController+Binding.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 05/11/2023.
//

import UIKit
import RxSwift

extension OnboardingViewController {
    
    func setupBindings() {
        bindCollectionView()
        bindPageControl()
        observeSizeChanges()
    }
    
    private func bindCollectionView() {
        viewModel.pages
            .bind(to: collectionView.rx.items(cellIdentifier: OnboardingCollectionViewCell.identifier, cellType: OnboardingCollectionViewCell.self)) { _, model, cell in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.didEndDecelerating
            .map { [unowned self] _ in self.currentPageIndex() }
            .subscribe(onNext: viewModel.setCurrentIndex)
            .disposed(by: disposeBag)
    }
    
    private func bindPageControl() {
        viewModel.currentIndex
            .observe(on: MainScheduler.instance)
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposeBag)
    }
    
    private func observeSizeChanges() {
        Observable.merge(
            rx.viewDidLayoutSubviews.map { _ in self.view.bounds.size },
            NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification).map { _ in self.view.bounds.size }
        )
        .distinctUntilChanged()
        .subscribe(onNext: { [unowned self] size in
            self.updateCollectionViewLayout(with: size)
        })
        .disposed(by: disposeBag)
    }
    
    func currentPageIndex() -> Int {
        let pageWidth = collectionView.frame.size.width
        return max(0, Int(collectionView.contentOffset.x / pageWidth))
    }
    
    func updateCollectionViewLayout(with size: CGSize) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: size.width, height: size.height)
            layout.invalidateLayout()
        }
    }
}
