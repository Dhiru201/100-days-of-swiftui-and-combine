//
//  CardDeckContainerView.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct CardDeckContainerView {
    @ObservedObject var viewModel: ViewModel = .init()
}


// MARK: - View
extension CardDeckContainerView: View {

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 22) {
                    Text("Time Remaining: \(self.viewModel.timeRemainingText)")
                        .font(.largeTitle)
                        .foregroundColor(Color.yellow)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .background(Capsule().fill(Color.black).opacity(0.7))
                    
                    
                    CardDeckView(
                        width: min(max(800, geometry.size.width) * 0.8, 480),
                        height: min(max(800, geometry.size.width) * 0.8, 480) * 0.5,
                        cards: self.viewModel.cards,
                        onRemove: { (card, index) in self.cardRemoved(at: index) }
                    )
                    .allowsHitTesting(self.viewModel.timeRemaining > 0)
                }
                    
                
                if self.viewModel.isDeckEmpty {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            self.resetButton
                        }
                    }
                }
            }
        }
        .padding()
        .padding()
        .background(Color("CardDeckBackground"))
        .edgesIgnoringSafeArea(.all)
    }
}


// MARK: - Computeds
extension CardDeckContainerView {
}


// MARK: - View Variables
extension CardDeckContainerView {
    
    private var resetButton: some View {
        Button("Start Again", action: viewModel.resetDeck)
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .clipShape(Capsule())
    }
}




// MARK: - Private Helpers
private extension CardDeckContainerView {
    func cardRemoved(at index: Int) {
        viewModel.cards.remove(at: index)
        
        if viewModel.isDeckEmpty {
            viewModel.pauseRound()
        }
    }
}



// MARK: - Preview
struct CardDeckContainerView_Previews: PreviewProvider {

    static var previews: some View {
        CardDeckContainerView()
            .environment(\.managedObjectContext, CurrentApp.coreDataManager.mainContext)
//            .previewLayout(PreviewLayout.iPhone11Landscape)
    }
}
