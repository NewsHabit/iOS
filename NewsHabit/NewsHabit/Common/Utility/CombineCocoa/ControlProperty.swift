//
//  ControlProperty.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import Combine
import UIKit.UIControl

// MARK: - Publisher
public extension Combine.Publishers {
    struct ControlProperty<Control: UIControl, Value>: Publisher {
        public typealias Output = Value
        public typealias Failure = Never
        
        private let control: Control
        private let controlEvents: Control.Event
        private let keyPath: KeyPath<Control, Value>
        
        public init(control: Control,
                    events: Control.Event,
                    keyPath: KeyPath<Control, Value>) {
            self.control = control
            self.controlEvents = events
            self.keyPath = keyPath
        }
        
        public func receive<S: Subscriber>(subscriber: S)
        where S.Failure == Failure, S.Input == Output {
            let subscription = Subscription(
                subscriber: subscriber,
                control: control,
                event: controlEvents,
                keyPath: keyPath
            )
            
            subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Subscription
@available(iOS 13.0, *)
extension Combine.Publishers.ControlProperty {
    private final class Subscription<
        S: Subscriber,
        Trigger: UIControl,
        ControlValue
    >: Combine.Subscription where S.Input == ControlValue {
        private var subscriber: S?
        weak private var control: Trigger?
        let keyPath: KeyPath<Trigger, ControlValue>
        private var didEmitInitial = false
        private let event: Trigger.Event
        
        init(
            subscriber: S,
            control: Trigger,
            event: Trigger.Event,
            keyPath: KeyPath<Trigger, ControlValue>
        ) {
            self.subscriber = subscriber
            self.control = control
            self.keyPath = keyPath
            self.event = event
            control.addTarget(self, action: #selector(processControlEvent), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {
            if !didEmitInitial,
               demand > .none,
               let control = control,
               let subscriber = subscriber {
                _ = subscriber.receive(control[keyPath: keyPath])
                didEmitInitial = true
            }
        }
        
        func cancel() {
            control?.removeTarget(self, action: #selector(processControlEvent), for: event)
            subscriber = nil
        }
        
        @objc private func processControlEvent() {
            guard let control = control else { return }
            _ = subscriber?.receive(control[keyPath: keyPath])
        }
    }
}

extension UIControl.Event {
    static var defaultValueEvents: UIControl.Event {
        return [.allEditingEvents, .valueChanged]
    }
}
