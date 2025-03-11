//
//  NotificationTimeViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/12/25.
//

import Combine
import Foundation

final class NotificationTimeViewModel: ViewModel {
    enum Action {
        case viewDidLoad
        case meridiemDidUpdate(meridiem: Meridiem)
        case hourDidUpdate(hour: Hour)
        case minuteDidUpdate(minute: Minute)
        case doneButtonDidTap
    }
    
    struct State {
        var initialMeridiem = PassthroughSubject<Meridiem, Never>()
        var initialHour = PassthroughSubject<Hour, Never>()
        var initialMinute = PassthroughSubject<Minute, Never>()
        var dismissPublisher = PassthroughSubject<String, Never>()
    }
    
    // MARK: - Properties
    
    var actionSubject = PassthroughSubject<Action, Never>()
    var cancellables = Set<AnyCancellable>()
    var state = State()
    
    private var meridiem: String?
    private var hour: String?
    private var minute: String?
    
    // MARK: - Init
    
    init(time: String) {
        let components = time.components(separatedBy: [" ", ":", " "]).filter { !$0.isEmpty }
        if components.count == 3 {
            meridiem = components[0]
            if let hourValue = Int(components[1]) {
                hour = String(hourValue) // "00" -> "0"
            }
            if let minuteValue = Int(components[2]) {
                minute = String(minuteValue) // "00" -> "0"
            }
        }
        
        actionSubject.sink { [weak self] action in
            self?.handleAction(action)
        }
        .store(in: &cancellables)
    }
    
    // MARK: - Handle Action Methods
    
    private func handleAction(_ action: Action) {
        switch action {
        case .viewDidLoad:
            initializeState()
        case .meridiemDidUpdate(let meridiem):
            self.meridiem = meridiem.rawValue
        case .hourDidUpdate(let hour):
            self.hour = hour.rawValue.filter { $0.isNumber }
        case .minuteDidUpdate(let minute):
            self.minute = minute.rawValue.filter { $0.isNumber }
        case .doneButtonDidTap:
            handleDoneButtonDidTap()
        }
    }
    
    private func initializeState() {
        if let meridiem = meridiem,
           let meridiemType = Meridiem(rawValue: meridiem) {
            state.initialMeridiem.send(meridiemType)
        }
        
        if let hour = hour,
           let hourType = Hour(rawValue: hour + "시") {
            state.initialHour.send(hourType)
        }
        
        if let minute = minute,
           let minuteType = Minute(rawValue: minute + "분") {
            state.initialMinute.send(minuteType)
        }
    }
    
    private func handleDoneButtonDidTap() {
        guard let meridiem = meridiem,
              let hour = hour,
              let minute = minute
        else { return }
        let formattedMinute = minute.count == 1 ? "0" + minute : minute // "0" -> "00"
        let time = "\(meridiem) \(hour) : \(formattedMinute)"
        state.dismissPublisher.send(time)
    }
}
