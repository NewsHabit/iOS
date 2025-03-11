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
        case viewDidLoad
        case switchDidToggle(isOn: Bool)
        case notificationTimeButtonDidTap
        case notificationTimeDidUpdate(time: String)
    }
    
    struct State {
        var isNotificationOn = CurrentValueSubject<Bool, Never>(false)
        var notificationTime = PassthroughSubject<String, Never>()
        var navigatePublisher = PassthroughSubject<String, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private var notificationTime = "오전 09:00"
    
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
        case .viewDidLoad:
            state.notificationTime.send(notificationTime)
        case .switchDidToggle(let isOn):
            state.isNotificationOn.send(isOn)
        case .notificationTimeButtonDidTap:
            state.navigatePublisher.send(notificationTime)
        case .notificationTimeDidUpdate(let time):
            state.notificationTime.send(time)
        }
    }
}
