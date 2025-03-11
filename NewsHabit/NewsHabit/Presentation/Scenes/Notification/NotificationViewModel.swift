//
//  NotificationViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/11/25.
//

import Combine
import Foundation

final class NotificationViewModel: ViewModel {
    enum Action {
        case switchDidToggle(isOn: Bool)
    }
    
    struct State {
        var isNotificationOn = CurrentValueSubject<Bool, Never>(false)
        var notificationTime = CurrentValueSubject<String, Never>("오전 09:00")
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
        case .switchDidToggle(let isOn):
            state.isNotificationOn.send(isOn)
        }
    }
}
