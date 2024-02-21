import SwiftUI
import SpriteKit

struct Level3View: View {
    
    @State var isShowingSheetLevel3 = false
    
    @State var showNextPhaseSheet = false
    
    @State var showFinalView = false
    
    @State var isShowingSheetHint = false
    
    @Binding var killLastScene: Bool
    
    @State var removeScene = false
    
    @State var jaViu = false
    
    var body: some View {
        ZStack {
            Color(hex: "0F6B00")
                .ignoresSafeArea()
            VStack {
                showTitle
                GeometryReader { geo in
                    if !removeScene {
                        SpriteView(scene: scene(size: geo.size))
                            .ignoresSafeArea()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            killLastScene.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                isShowingSheetLevel3 = true
            }
        }
        .sheet(isPresented: $isShowingSheetLevel3) {
            sheetLoopsL3(isShowing: $isShowingSheetLevel3, jaViu: $jaViu)
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $isShowingSheetHint) {
            sheetHint(isShowing: $isShowingSheetHint)
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $showNextPhaseSheet) {
            sheetLevel3Concluido(showNextPhaseSheet: $showNextPhaseSheet, showNext: $showFinalView)
                .interactiveDismissDisabled(true)
        }
        .background(
            NavigationLink(destination: FinalView(killLastScene: $removeScene), isActive: $showFinalView) {
                
            }
        )
    }
    
    var showTitle: some View {
        HStack {
            Button {
                isShowingSheetHint = true
            } label: {
                Image("hint-lamp")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(20)
            }
            Spacer()
            Text("LEVEL 3")
                .font(Font.custom("Itim-Regular", size:60))
                .foregroundColor(.white)
                .padding(.top, 20)
            Spacer()
            Button {
                isShowingSheetLevel3 = true
                jaViu = true
            } label: {
                Image("comment-info 1")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(20)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 10)
    }
    
    func didFinishGame(_ newValue:Bool) {
        DispatchQueue.main.async {
            showNextPhaseSheet = newValue
        }
    }
    
    func scene(size:CGSize)->SKScene {
        let spriteView = GameSceneLevel3(size: size)
        
        spriteView.size = size
        spriteView.scaleMode = .aspectFill
        spriteView.anchorPoint = .init(x: 0.5, y: 0.5)
        
        spriteView.didFinishGame = didFinishGame
        didFinishGame(spriteView.showNextPhaseSheet)
        
        return spriteView
    }
}

struct sheetLoopsL3: View {
    
    @Binding var isShowing: Bool
    
    @Binding var jaViu: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "17A600")
                VStack {
                    Spacer()
                    showTitle
                    Spacer()
                    Text("A loop is a structure that repeats the instructions inside infinetly, until it satisfies a certain condition. In our case, the condition is the snake escaping")
                        .font(Font.custom("Itim-Regular", size:30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                    Spacer()
                    Image("ex-loop")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Spacer()
                    VStack {
                        Text("In the example above, our snake would keep going forward until it escapes")
                            .font(Font.custom("Itim-Regular", size:30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(20)
                    }
                    Spacer()
                    bottomPart
                }
            }.ignoresSafeArea()
        }.navigationBarHidden(true)
    }
    
    var showTitle: some View {
        HStack {
            Text("Loops")
                .font(Font.custom("Itim-Regular", size:80))
                .foregroundColor(.white)
        }
    }
    
    var bottomPart: some View {
        HStack {
            Spacer()
            NavigationLink(destination: sheetLoopsL3_2(isShowing: $isShowing, jaViu: $jaViu)) {
                Image("proximo-botao")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 9)
    }
}

struct sheetLoopsL3_2: View {
    
    @Binding var isShowing: Bool
    
    @Binding var jaViu: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Spacer()
                showTitle
                Spacer()
                Text("A loop is delimited by the dotted rectangle with the loop symbol on the top left corner")
                    .font(Font.custom("Itim-Regular", size:30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(20)
                Spacer()
                Image("loop-frame-example")
                    .resizable()
                    .frame(width: 634, height: 200)
                Spacer()
                VStack {
                    Text("That means that every instruction inside the dotted rectangle is part of the loop")
                        .font(Font.custom("Itim-Regular", size:30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                }
                Spacer()
                bottomPart
            }
        }.navigationBarHidden(true)
    }
    
    var showTitle: some View {
        HStack {
            Text("Loops")
                .font(Font.custom("Itim-Regular", size:80))
                .foregroundColor(.white)
        }
    }
    
    var bottomPart: some View {
        HStack {
            CustomBackButtonSheet()
            Spacer()
            NavigationLink(destination: sheetLoopsL3_3(isShowing: $isShowing, jaViu: $jaViu)) {
                Image("proximo-botao")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 9)
    }
}

struct sheetLoopsL3_3: View {
    
    @Binding var isShowing: Bool
    
    @Binding var jaViu: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Spacer()
                showTitle
                Spacer()
                Text("We can have a conditional nested in a loop")
                    .font(Font.custom("Itim-Regular", size:30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(20)
                Spacer()
                Image("loop-conditional")
                    .resizable()
                    .frame(width: 634, height: 200)
                Spacer()
                VStack {
                    Text("Wich means that, during every execution of the loop, the condition is gonna be tested")
                        .font(Font.custom("Itim-Regular", size:30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(20)
                }
                Spacer()
                bottomPart
            }
        }.navigationBarHidden(true)
    }
    
    var showTitle: some View {
        HStack {
            Text("Loops and contidionals")
                .font(Font.custom("Itim-Regular", size:65))
                .foregroundColor(.white)
        }
    }
    
    var bottomPart: some View {
        HStack {
            if !jaViu {
                CustomBackButtonSheet()
                Spacer()
                NavigationLink(destination: sheetLevel3(isShowing: $isShowing)) {
                    Image("proximo-botao")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                }
            } else {
                Spacer()
                Button {
                    isShowing = false
                } label: {
                    Image("continue-button")
                        .resizable()
                }
                .frame(width: 175, height: 109.3)
                .padding(.bottom, 50)
                Spacer()
            }
        }
        .frame(height: UIScreen.main.bounds.height / 9)
    }
}

struct sheetLevel3: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Spacer()
                Text("LEVEL 3")
                    .font(Font.custom("Itim-Regular", size:80))
                    .foregroundColor(.white)
                Spacer()
                Text("Eat the apples and escape")
                    .font(Font.custom("Itim-Regular", size:40))
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Spacer()
                    Text("1x")
                        .font(Font.custom("Itim-Regular", size:80))
                        .foregroundColor(.white)
                    Image("apple-sheet")
                    Spacer()
                    Text("3x")
                        .font(Font.custom("Itim-Regular", size:80))
                        .foregroundColor(.white)
                    Image("up-arrow")
                    Spacer()
                }
                Spacer()
                Button {
                    isShowing = false
                } label: {
                    Image("continue-button")
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct sheetLevel3Concluido: View {
    
    @Binding var showNextPhaseSheet: Bool
    
    @Binding var showNext: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Text("LEVEL 3")
                    .font(Font.custom("Itim-Regular", size:80))
                    .foregroundColor(.white)
                Text("COMPLETED")
                    .font(Font.custom("Itim-Regular", size:80))
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                HStack {
                    Image("star")
                    Image("star")
                        .padding(.bottom, 25)
                    Image("star")
                }
                Button {
                    showNextPhaseSheet = false
                    DispatchQueue.main.async {
                        showNext = true
                    }
                    
                } label: {
                    Image("proximo-botao")
                    
                }

            }
        }
    }
}

struct sheetHint: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Text("Hint")
                    .font(Font.custom("Itim-Regular", size:80))
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                Spacer()
                VStack {
                    Text("REMEMBER!!!")
                        .font(Font.custom("Itim-Regular", size:50))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    HStack {
                        Image("apple-in-square-game")
                        Text("   Checks if the apple is in the square right in front of the snake")
                            .font(Font.custom("Itim-Regular", size:30))
                            .foregroundColor(.white)
                            .padding(.bottom, 25)
                            .padding(.trailing, 25)
                    }
                }
                Spacer()
                bottomPart
            }
            .padding(20)
        }.navigationBarHidden(true)
    }
    
    var bottomPart: some View {
        HStack {
            Spacer()
            Button {
                isShowing = false
            } label: {
                Image("continue-button")
                    .resizable()
            }
            .frame(width: 175, height: 109.3)
            .padding(.bottom, 50)
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.height / 9)
    }
}
