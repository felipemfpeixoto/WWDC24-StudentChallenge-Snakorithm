import SwiftUI
import SpriteKit

struct Level2View: View {
    
    @State var isShowingSheetLevel2 = false
    
    @State var showNextPhaseSheet = false
    
    @State var showLevel3View = false
    
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
                isShowingSheetLevel2 = true
            }
        }
        .sheet(isPresented: $isShowingSheetLevel2) {
            sheetConditionalsL2(isShowing: $isShowingSheetLevel2, jaViu: $jaViu)
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $showNextPhaseSheet) {
            sheetLevel2Concluido(showNextPhaseSheet: $showNextPhaseSheet, showNext: $showLevel3View)
                .interactiveDismissDisabled(true)
        }
        .background(
            NavigationLink(destination: Level3View(killLastScene: $removeScene), isActive: $showLevel3View) {
                
            }
        )
    }
    
    var showTitle: some View {
        HStack {
            Text("LEVEL 2")
                .font(Font.custom("Itim-Regular", size:60))
                .foregroundColor(.white)
                .padding(.top, 20)
                .padding(.leading, UIScreen.main.bounds.width / 2 - 100)
            Spacer()
            Button {
                isShowingSheetLevel2 = true
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
        let spriteView = GameSceneLevel2(size: size)
        
        spriteView.size = size
        spriteView.scaleMode = .aspectFill
        spriteView.anchorPoint = .init(x: 0.5, y: 0.5)
        
        spriteView.didFinishGame = didFinishGame
        didFinishGame(spriteView.showNextPhaseSheet)
        
        return spriteView
    }
}

struct sheetLevel2: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Spacer()
                Text("LEVEL 2")
                    .font(Font.custom("Itim-Regular", size:80))
                    .foregroundColor(.white)
                Spacer()
                Text("Eat the apples and escape")
                    .font(Font.custom("Itim-Regular", size:40))
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                Spacer()
                HStack {
                    Spacer()
                    Text("1x")
                        .font(Font.custom("Itim-Regular", size:80))
                        .foregroundColor(.white)
                    Image("apple-sheet")
                    Spacer()
                    Text("5x")
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
        }.navigationBarHidden(true)
    }
}

struct sheetConditionalsL2: View {
    
    @Binding var isShowing: Bool
    
    @Binding var jaViu: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "17A600")
                VStack {
                    showTitle
                    Spacer()
                    VStack {
                        Text("A conditional is a structure that checks if a condition is valid. If it is, it does a certain action, if its not, then it does a different action")
                            .font(Font.custom("Itim-Regular", size:30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image("if-block")
                                .resizable()
                                .frame(width: 80, height: 80)
                            Image("apple-in-square")
                                .resizable()
                                .frame(width: 80, height: 80)
                            Image("do-block")
                                .resizable()
                                .frame(width: 80, height: 80)
                            Image("A-square")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                        HStack {
                            Image("else-block")
                                .resizable()
                                .frame(width: 200,height: 80)
                            Image("B-square")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                    }
                    Spacer()
                    VStack {
                        Text("In the example above: If 'APPLE IS IN FRONT OF THE SNAKE', do 'A', else, do 'B'")
                            .font(Font.custom("Itim-Regular", size:30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    bottomPart
                }
                .padding(20)
            }.ignoresSafeArea()
        }.navigationBarHidden(true)
    }
    
    var showTitle: some View {
        HStack {
            Text("Conditionals")
                .font(Font.custom("Itim-Regular", size:80))
                .foregroundColor(.white)
        }
    }
    
    var bottomPart: some View {
        HStack {
            Spacer()
            NavigationLink(destination: sheetNewComands(isShowing: $isShowing, jaViu: $jaViu)) {
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


struct sheetNewComands: View {
    
    @Binding var isShowing: Bool
    
    @Binding var jaViu: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Spacer()
                Text("New Blocks")
                    .font(Font.custom("Itim-Regular", size:80))
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
                Spacer()
                HStack {
                    Text("Condition:")
                        .font(Font.custom("Itim-Regular", size:50))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    Spacer()
                }
                HStack {
                    Image("apple-in-square-game")
                    Text("   Checks if the apple is in the square right in front of the snake")
                        .font(Font.custom("Itim-Regular", size:30))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                        .padding(.trailing, 25)
                }
                Spacer()
                HStack {
                    Text("New comand:")
                        .font(Font.custom("Itim-Regular", size:50))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                    Spacer()
                }
                HStack {
                    Image("stop-block-game")
                    Text("   Stops the snake for 2 seconds, to wait for the apple to come back")
                        .font(Font.custom("Itim-Regular", size:30))
                        .foregroundColor(.white)
                        .padding(.bottom, 25)
                        .padding(.trailing, 25)
                }
                Spacer()
                bottomPart
            }
            .padding(20)
        }.navigationBarHidden(true)
    }
    
    var bottomPart: some View {
        HStack {
            if !jaViu {
                HStack {
                    CustomBackButtonSheet()
                    Spacer()
                    NavigationLink(destination: sheetLevel2(isShowing: $isShowing)) {
                        Image("proximo-botao")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .padding(.bottom, 20)
                    }
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

struct sheetLevel2Concluido: View {
    
    @Binding var showNextPhaseSheet: Bool
    
    @Binding var showNext: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Text("LEVEL 2")
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

struct CustomBackButtonSheet: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("voltar-botao")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
            }
        }
    }
}
