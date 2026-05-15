//
//  QuotesView.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

import SwiftUI

struct GymQuotesView: View {
    @State private var currentQuote: String = ""
    @State private var quoteTimer: Timer?
    
    private let gymQuotes = [
        "No pain, no gain! 💪",
        "Your body can stand almost anything. It's your mind that you have to convince.",
        "The only bad workout is the one that didn't happen.",
        "Sweat is just fat crying. Keep grinding! 🔥",
        "Stronger every day, that's the way!",
        "Your future self will thank you for this workout.",
        "Don't wish for it, work for it! 🎯",
        "Fitness is not about being better than someone else, it's about being better than you were.",
        "Train insane or remain the same.",
        "Push yourself, because no one else is going to do it for you.",
        "The pain you feel today will be the strength you feel tomorrow.",
        "Your only limit is you! 🚀"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.secondarySystemBackground)
                    .frame(height: 200)
                    .cornerRadius(20)
                    .overlay {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Motivation")
                                .foregroundStyle(.main)
                                .font(.title)
                                .fontWeight(.semibold)
                            
                            Text(currentQuote)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .lineLimit(4)
                                .transition(.opacity)
                            
                            Spacer()
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
            }
            .frame(width: 370)
            .onAppear {
                currentQuote = gymQuotes.randomElement() ?? ""
                startQuoteTimer()
            }
            .onDisappear {
                stopQuoteTimer()
            }
        }
    }
    
    private func startQuoteTimer() {
        quoteTimer = Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                currentQuote = gymQuotes.randomElement() ?? ""
            }
        }
    }
    
    private func stopQuoteTimer() {
        quoteTimer?.invalidate()
        quoteTimer = nil
    }
}

#Preview {
    GymQuotesView()
}
