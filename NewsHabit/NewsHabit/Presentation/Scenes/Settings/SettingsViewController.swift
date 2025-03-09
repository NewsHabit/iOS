//
//  SettingsViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/9/25.
//

import UIKit

final class SettingsViewController: BaseViewController<SettingsView> {
    // Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.configure(with: SettingsModel(
            name: "지연",
            category: "IT/과학",
            dailyGoal: "3개",
            notification: "OFF"
        ))
    }
}
