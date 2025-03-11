//
//  BottomSheetViewController.swift
//  NewsHabit
//
//  Created by 지연 on 3/12/25.
//

import UIKit

class BottomSheetViewController<View: UIView>: UIViewController {
    private let animationDuration = 0.25
    private let bottomSheetHeight: CGFloat
    
    // MARK: - Components
    
    private let dimmedView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let contentView = {
        let view = View()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    // MARK: - Init
    
    init(bottomSheetHeight: CGFloat) {
        self.bottomSheetHeight = bottomSheetHeight
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        contentView.snp.remakeConstraints { make in
            make.height.equalTo(bottomSheetHeight)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.dimmedView.backgroundColor = .black.withAlphaComponent(0.7)
            self.view.layoutIfNeeded()
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        contentView.snp.remakeConstraints { make in
            make.height.equalTo(bottomSheetHeight)
            make.top.equalTo(view.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        UIView.animate(withDuration: animationDuration) {
            self.dimmedView.backgroundColor = .clear
            self.view.layoutIfNeeded()
        } completion: { _ in
            super.dismiss(animated: false, completion: completion)
        }
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.height.equalTo(bottomSheetHeight)
            make.top.equalTo(view.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupGestureRecognizer() {
        // TapGesture
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDimmedViewTap)
        )
        dimmedView.addGestureRecognizer(tapGesture)
        
        // SwipeGesture
        let swipeGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleDownSwipe)
        )
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleDimmedViewTap(_ tapRecognizer: UITapGestureRecognizer) {
        dismiss(animated: false)
    }
    
    @objc private func handleDownSwipe(_ swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .ended,
           case .down = swipeRecognizer.direction{
            dismiss(animated: false)
        }
    }
}
