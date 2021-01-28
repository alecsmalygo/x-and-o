//
//  ContentView.swift
//  Shared
//
//  Created by This Is Alec's Account on 1/28/21.
//

import SwiftUI
 
struct ContentView: View {
    var body: some View {
        
        NavigationView {
            Home()
                .navigationTitle("epilepsy warning lol")
                .preferredColorScheme(.dark)
        }
    }
}
 
struct Home : View {
    
    // Number of moves I can make
    @State var moves : [String] = Array(repeating: "", count: 9)
    // To identify the current player
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
    var body: some View {
        VStack {
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 1), count: 3), spacing: 11) {
                
                ForEach(0..<9, id: \.self) { index in
                    
                    ZStack {
                        
                        Color("white ii")
                        
                        Color("white ii")
                            .opacity(moves[index] == "" ? 0 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.light)
                            .foregroundColor(.white)
                            
                    }
                    
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(0)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 2949120 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .bottomTrailing,
                        anchorZ: 2.0,
                        perspective: 10.0
                    )
                    
                    .onTapGesture(perform: {
                        withAnimation(Animation
                                        .easeIn(duration: 15.0)) {
                            
                            if moves[index] == "" {
                                moves[index] = isPlaying ? "x" : "o"
                            isPlaying.toggle()
                            }
                        }
                    })
                    
                }
                
            }
            
            .padding(15)
            
        }
        
        //Whenever moves update it will check winner
        .onChange(of: moves, perform: { value in
            
            checkWinner()
        })
        
        .alert(isPresented: $gameOver, content: {
            
            Alert(title: Text("winner"), message: Text(msg), dismissButton: .destructive(Text("play again"), action: {
                
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                    
                }
                    
            }))
            
        })
        
    }
    
    // Calculating Width
    
    func getWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 3
    }
    
    func checkWinner() {
        
        if checkMoves(player: "x") {
            
            msg = "x wins"
            gameOver.toggle()
        }
        
        if checkMoves(player: "o") {
            
            msg = "o wins"
            gameOver.toggle()
            
        } else {
            
            let status = moves.contains { (value) -> Bool in
                
                return value == ""
                
            }
            
            if !status {
                
                msg = "tie"
                gameOver.toggle()
            }
        }
    }
    
    func checkMoves(player: String) -> Bool {
        // Checking for horizontal moves
        for contestant in stride(from: 0, to: 9, by: 3) {
            if moves[contestant] == player &&
                moves[contestant+1] == player &&
                moves[contestant+2] == player {
                
                return true
            }
        }
            
            // Checking for vertical moves
            for contestant in 0...2 {
                if moves[contestant] == player &&
                    moves[contestant+3] == player &&
                    moves[contestant+6] == player {
                    
                    return true
                }
            
            }
        
            // Checking for diagonal moves
        if moves[2] == player && moves [4] == player && moves [8] == player {
            
            return true
        }
        
        if moves[2] == player && moves [4] == player && moves [8] == player {
            
            return true
        }
    
    return false
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
