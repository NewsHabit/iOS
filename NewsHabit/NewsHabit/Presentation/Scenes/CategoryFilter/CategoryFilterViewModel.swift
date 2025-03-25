//
//  CategoryFilterViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Combine
import Foundation

final class CategoryFilterViewModel: ViewModel {
    enum Action {
        case viewDidLoad
        case categoryFilterCellDidSelect(index: Int)
    }
    
    struct State {
        var categoryFilterModels = CurrentValueSubject<[CategoryFilterCellModel], Never>([])
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
        case .categoryFilterCellDidSelect(let index):
            handleCategoryFilterCellDidSelect(at: index)
        }
    }
    
    private func initializeState() {
        let categoryFilterList = ["전체 카테고리"] + Category.allCases.map { $0.name }
        let categoryFilterModels = categoryFilterList.map {
            CategoryFilterCellModel(filterName: $0, isSelected: $0 == "전체 카테고리")
        }
        state.categoryFilterModels.send(categoryFilterModels)
    }
    
    private func handleCategoryFilterCellDidSelect(at selectedIndex: Int) {
        let updatedCategoryFilterCellModels = state.categoryFilterModels.value.enumerated().map {
            (index, model) in
            var updatedModel = model
            updatedModel.isSelected = index == selectedIndex
            return updatedModel
        }
        state.categoryFilterModels.send(updatedCategoryFilterCellModels)
    }
}
