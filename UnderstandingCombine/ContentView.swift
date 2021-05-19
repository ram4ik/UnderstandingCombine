//
//  ContentView.swift
//  UnderstandingCombine
//
//  Created by ramil on 19.05.2021.
//

import SwiftUI
import Combine

public protocol Publisher {
    associatedtype Output
    associatedtype Failure: Error
    func subscribe<S>(_ subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input
}

public protocol Subscriber: CustomCombineIdentifierConvertible {
    associatedtype Input
    associatedtype Failure: Error
    func receive(subscriber: Subscription)
    func receive(_ input: Self.Input) -> Subscribers.Demand
    func receive(completion: Subscribers.Completion<Self.Failure>)
}

struct ContentView: View {
    let publisher = [1, 2, 3, 4].publisher
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
        }.onAppear() {
            run()
        }
    }
    
    private func run() {
        _ = publisher
            .filter {$0 % 2 == 0}
            .sink {print($0)}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
