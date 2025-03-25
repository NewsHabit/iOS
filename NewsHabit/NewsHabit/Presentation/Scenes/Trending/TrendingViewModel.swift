//
//  TrendingViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Combine
import Foundation

final class TrendingViewModel: ViewModel {
    enum Action {
        case viewWillAppear
    }
    
    struct State {
        var subTitle = PassthroughSubject<String, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    // MARK: - Init
    
    init() {
        actionSubject.sink { [weak self] action in
            self?.handleAction(action)
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .viewWillAppear:
            updateState()
        }
    }
    
    private func updateState() {
        state.subTitle.send(Date().formatAsFullDateTime())
    }
}
