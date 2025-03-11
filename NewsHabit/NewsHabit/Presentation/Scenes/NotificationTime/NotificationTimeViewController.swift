//
//  NotificationTimeViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/12/25.
//

import Combine
import UIKit

protocol NotificationTimeViewControllerDelegate: AnyObject {
    func notificationTimeDidUpdate(time: String)
}

final class NotificationTimeViewController: BottomSheetViewController<NotificationTimeView> {
    weak var delegate: NotificationTimeViewControllerDelegate?
    private let viewModel: NotificationTimeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: NotificationTimeViewModel) {
        self.viewModel = viewModel
        super.init(bottomSheetHeight: 583)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.send(.viewDidLoad)
    }
    
    // MARK: - Setup Methods
    
    private func setupBindings() {
        // action
        meridiemSelectionView.valuePublisher
            .sink { [weak self] meridiem in
                self?.viewModel.send(.meridiemDidUpdate(meridiem: meridiem))
            }
            .store(in: &cancellables)
        
        hourSelectionView.valuePublisher
            .sink { [weak self] hour in
                self?.viewModel.send(.hourDidUpdate(hour: hour))
            }
            .store(in: &cancellables)
        
        minuteSelectionView.valuePublisher
            .sink { [weak self] minute in
                self?.viewModel.send(.minuteDidUpdate(minute: minute))
            }
            .store(in: &cancellables)
        
        doneButton.tapPublisher
            .sink { [weak self] in
                self?.viewModel.send(.doneButtonDidTap)
            }
            .store(in: &cancellables)
        
        // state
        viewModel.state.initialMeridiem
            .receive(on: RunLoop.main)
            .sink { [weak self] meridiem in
                self?.meridiemSelectionView.meridiem = meridiem
            }
            .store(in: &cancellables)
        
        viewModel.state.initialHour
            .receive(on: RunLoop.main)
            .sink { [weak self] hour in
                self?.hourSelectionView.hour = hour
            }
            .store(in: &cancellables)
        
        viewModel.state.initialMinute
            .receive(on: RunLoop.main)
            .sink { [weak self] minute in
                self?.minuteSelectionView.minute = minute
            }
            .store(in: &cancellables)
        
        viewModel.state.dismissPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] time in
                guard let self = self else { return }
                delegate?.notificationTimeDidUpdate(time: time)
                dismiss(animated: false)
            }
            .store(in: &cancellables)
    }
}

private extension NotificationTimeViewController {
    var meridiemSelectionView: MeridiemSelectionView {
        contentView.meridiemSelectionView
    }
    
    var hourSelectionView: HourSelectionView {
        contentView.hourSelectionView
    }
    
    var minuteSelectionView: MinuteSelectionView {
        contentView.minuteSelectionView
    }
    
    var doneButton: UIButton {
        contentView.doneButton
    }
}
