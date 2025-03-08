//
//  CategoryViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/7/25.
//

import Combine

final class CategoryViewModel: ViewModel {
    enum Action {
        case viewDidLoad
        case categoryCellDidSelect(index: Int)
    }
    
    struct State {
        var categoryModels = CurrentValueSubject<[CategoryModel], Never>([])
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
        case .categoryCellDidSelect(let index):
            handleCategoryCellDidSelected(at: index)
        }
    }
    
    private func initializeState() {
        let categoryModels = Category.allCases.map { category in
            return CategoryModel(name: category.name, isSelected: false)
        }
        state.categoryModels.send(categoryModels)
    }
    
    private func handleCategoryCellDidSelected(at index: Int) {
        var categoryModels = state.categoryModels.value
        categoryModels[index].isSelected.toggle()
        state.categoryModels.send(categoryModels)
    }
}

