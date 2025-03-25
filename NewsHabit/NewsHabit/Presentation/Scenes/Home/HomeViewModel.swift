//
//  HomeViewModel.swift
//  NewsHabit
//
//  Created by 지연 on 3/25/25.
//

import Combine
import Foundation

final class HomeViewModel: ViewModel {
    enum Action {
        case viewDidLoad
    }
    
    struct State {
        var allReadCount = PassthroughSubject<Int, Never>()
        var todayNewsModels = CurrentValueSubject<[NewsModel], Never>([])
        var currentYearMonth = PassthroughSubject<String, Never>()
        var isPrevButtonEnabled = PassthroughSubject<Bool, Never>()
        var isNextButtonEnabled = PassthroughSubject<Bool, Never>()
        var monthlyAllReadCount = PassthroughSubject<Int, Never>()
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
        }
    }
    
    private func initializeState() {
        state.allReadCount.send(8)
        state.todayNewsModels.send([
            NewsModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .science, isUnread: true),
            NewsModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .lifestyle, isUnread: true),
            NewsModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .economy, isUnread: true)
        ])
        state.currentYearMonth.send(Date().formatAsYearMonth())
        state.isPrevButtonEnabled.send(true)
        state.isNextButtonEnabled.send(false)
        state.monthlyAllReadCount.send(8)
    }
}
