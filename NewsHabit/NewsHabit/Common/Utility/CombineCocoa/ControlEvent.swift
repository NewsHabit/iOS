//
//  ControlEvent.swift
//  NewsHabit
//
//  Created by 지연 on 3/2/25.
//

import Combine
import UIKit.UIControl

public extension Combine.Publishers {
    struct ControlEvent<Control: UIControl>: Publisher {
        public typealias Output = Void
        public typealias Failure = Never

        private let control: Control
        private let controlEvents: Control.Event

        public init(control: Control,
                    events: Control.Event) {
            self.control = control
            self.controlEvents = events
        }

        public func receive<S: Subscriber>(subscriber: S)
        where S.Failure == Failure, S.Input == Output {
            let subscription = Subscription(
                subscriber: subscriber,
                control: control,
                event: controlEvents
            )
            
            subscriber.receive(subscription: subscription)
        }
    }
}

// MARK: - Subscription
extension Combine.Publishers.ControlEvent {
    private final class Subscription<S: Subscriber, Trigger: UIControl>: Combine.Subscription
    where S.Input == Void {
        private var subscriber: S?
        weak private var control: Trigger?

        init(subscriber: S, control: Trigger, event: Trigger.Event) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(processControlEvent), for: event)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            subscriber = nil
        }

        @objc private func processControlEvent() {
            _ = subscriber?.receive()
        }
    }
}
