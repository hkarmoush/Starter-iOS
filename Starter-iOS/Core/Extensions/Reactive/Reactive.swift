//
//  Reactive.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 03/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewDidLayoutSubviews: ControlEvent<Void> {
        let events = self.methodInvoked(#selector(Base.viewDidLayoutSubviews)).map { _ in }
        return ControlEvent(events: events)
    }
}
