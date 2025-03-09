//
//  DailyGoalViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import Combine

final class DailyGoalViewModel: ViewModel {
    enum Action {
        case viewDidLoad
        case dailyGoalCellDidSelect(index: Int)
    }
    
    struct State {
        var dailyGoalModels = CurrentValueSubject<[DailyGoalModel], Never>([])
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
        case .viewDidLoad:
            initializeState()
        case .dailyGoalCellDidSelect(let index):
            handleDailyGoalCellDidSelected(at: index)
        }
    }
    
    private func initializeState() {
        let dailyGoalModels = DailyGoal.allCases.map { dailyGoal in
            return DailyGoalModel(
                description: dailyGoal.desctiption,
                count: dailyGoal.count,
                isSelected: false
            )
        }
        state.dailyGoalModels.send(dailyGoalModels)
    }
    
    private func handleDailyGoalCellDidSelected(at index: Int) {
        var dailyGoalModels = DailyGoal.allCases.map { dailyGoal in
            return DailyGoalModel(
                description: dailyGoal.desctiption,
                count: dailyGoal.count,
                isSelected: false
            )
        }
        dailyGoalModels[index].isSelected.toggle()
        state.dailyGoalModels.send(dailyGoalModels)
    }
}


