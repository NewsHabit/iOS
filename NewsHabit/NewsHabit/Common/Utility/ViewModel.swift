//
//  ViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/7/25.
//

import Combine

protocol ViewModel {
    associatedtype Action
    associatedtype State
    
    var actionSubject: PassthroughSubject<Action, Never> { get }
    var cancellables: Set<AnyCancellable> { get set }
    var state: State { get set }
    
    func send(_ action: Action)
}

extension ViewModel {
    func send(_ action: Action) {
        actionSubject.send(action)
    }
}
