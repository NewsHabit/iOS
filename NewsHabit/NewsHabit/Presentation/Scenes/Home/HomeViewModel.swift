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
        var todayNewsModels = CurrentValueSubject<[NewsCellModel], Never>([])
        var currentYearMonth = PassthroughSubject<String, Never>()
        var isPrevButtonEnabled = PassthroughSubject<Bool, Never>()
        var isNextButtonEnabled = PassthroughSubject<Bool, Never>()
        var monthlyAllReadCount = PassthroughSubject<Int, Never>()
        var myRecordModels = CurrentValueSubject<[DayCellModel], Never>([])
        var currentCategory = CurrentValueSubject<String, Never>("전체 카테고리")
        var bookmarkModels = CurrentValueSubject<[NewsCellModel], Never>([])
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
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .science, isUnread: true),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .lifestyle, isUnread: true),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .economy, isUnread: true)
        ])
        state.currentYearMonth.send(Date().formatAsYearMonth())
        state.isPrevButtonEnabled.send(true)
        state.isNextButtonEnabled.send(false)
        state.monthlyAllReadCount.send(8)
        state.myRecordModels.send([
            DayCellModel(type: .empty),
            DayCellModel(type: .empty),
            DayCellModel(type: .empty),
            DayCellModel(type: .empty),
            DayCellModel(type: .empty),
            DayCellModel(day: "1", type: .unread),
            DayCellModel(day: "2", type: .unread),
            DayCellModel(day: "3", type: .read),
            DayCellModel(day: "4", type: .read),
            DayCellModel(day: "5", type: .read),
            DayCellModel(day: "6", type: .read),
            DayCellModel(day: "7", type: .read),
            DayCellModel(day: "8", type: .unread),
            DayCellModel(day: "9", type: .unread),
            DayCellModel(day: "10", type: .read),
            DayCellModel(day: "11", type: .read),
            DayCellModel(day: "12", type: .read),
            DayCellModel(day: "13", type: .today),
            DayCellModel(day: "14", type: .unread),
            DayCellModel(day: "15", type: .unread),
            DayCellModel(day: "16", type: .unread),
            DayCellModel(day: "17", type: .unread),
            DayCellModel(day: "18", type: .unread),
            DayCellModel(day: "19", type: .unread),
            DayCellModel(day: "20", type: .unread),
            DayCellModel(day: "21", type: .unread),
            DayCellModel(day: "22", type: .unread),
            DayCellModel(day: "23", type: .unread),
            DayCellModel(day: "24", type: .unread),
            DayCellModel(day: "25", type: .unread),
            DayCellModel(day: "26", type: .unread),
            DayCellModel(day: "27", type: .unread),
            DayCellModel(day: "28", type: .unread),
            DayCellModel(day: "29", type: .unread),
            DayCellModel(day: "30", type: .unread),
            DayCellModel(day: "31", type: .unread),
        ])
        state.bookmarkModels.send([
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .science),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .lifestyle),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .economy),
            NewsCellModel(title: "애플, 19일 신제품 출시 예고... “홈버튼 없앤 아이폰 SE4”", description: "애플이 오는 19일 신제품을 출시할 계획이라고 밝혔다. 이번에 출시될 모델을 두고 업계에서는 보급형 아이폰 SE4로 관측하고 있다. 팀 쿡 애플 최고경영자(CEO)는 13일(현지시간) 소셜미디어 엑스(옛 트위터)에 “새로운 가족을 만날 준비를 하라. 2월 19일 애플 출시”라고 알렸다.", category: .politics)
        ])
    }
}
