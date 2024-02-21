import SwiftUI
import SpriteKit

var spriteViewTutorial: TutorialScene?

struct Level1View: View {
    
    @ObservedObject private var audioManager = AudioManager.shared
    
    @State var isShowing = false // continuar o sheet
    
    @State var showNextPhaseSheet = false // verifica se a fase foi concluida
    
    @State var showLevel2View = false
    
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
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isShowing = true
            }
        }
        .sheet(isPresented: $isShowing) {
            sheetTutorial(isShowing: $isShowing, jaViu: $jaViu)
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $showNextPhaseSheet) {
            sheetLevelConcluido(showNextPhaseSheet: $showNextPhaseSheet, showNext: $showLevel2View)
                .interactiveDismissDisabled(true)
        }
        .background(
            NavigationLink(destination: Level2View(killLastScene: $removeScene), isActive: $showLevel2View) {
                
            }
        )
    }
    
    var showTitle: some View {
        HStack {
            Text("LEVEL 1")
                .font(Font.custom("Itim-Regular", size:60))
                .foregroundColor(.white)
                .padding(.top, 20)
                .padding(.leading, UIScreen.main.bounds.width / 2 - 100)
            Spacer()
            Button {
                isShowing = true
                jaViu = true
            } label: {
                Image("comment-info 1")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(20)
            }
        }
        .frame(height: UIScreen.main.bounds.height / 8)
    }
    
    func scene(size:CGSize)->SKScene {
        let spriteView = GameSceneLevel1(size: size)
        
        spriteView.size = size
        spriteView.scaleMode = .aspectFill
        spriteView.anchorPoint = .init(x: 0.5, y: 0.5)
        
        spriteView.didFinishGame = didFinishGame
        didFinishGame(spriteView.showNextPhaseSheet)
        
        return spriteView
    }
    
    func didFinishGame(_ newValue:Bool) {
        DispatchQueue.main.async {
            showNextPhaseSheet = newValue
        }
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("back-arrow 1")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(20)
            }
        }
    }
}

struct sheetTutorial: View {
    
    @Binding var isShowing: Bool
    
    @Binding var jaViu: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "17A600")
                VStack {
                    showTitle
                    GeometryReader { geo in
                        SpriteView(scene: scene(size: geo.size))
                    }
                    bottomPart
                }
            }
            .ignoresSafeArea()
        }.navigationBarHidden(true)
    }
    
    var showTitle: some View {
        HStack {
            Text("Tutorial")
                .font(Font.custom("Itim-Regular", size:80))
                .foregroundColor(.white)
        }
        .frame(height: UIScreen.main.bounds.height / 10)
    }
    
    var bottomPart: some View {
        HStack {
            if !jaViu {
                Spacer()
                NavigationLink(destination: sheetLevel1(isShowing: $isShowing)) {
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
    
    func scene(size:CGSize)->SKScene {
        let spriteViewTutorial = TutorialScene(size: size)

        spriteViewTutorial.size = size
        spriteViewTutorial.scaleMode = .aspectFill
        spriteViewTutorial.anchorPoint = .init(x: 0.5, y: 0.5)

        return spriteViewTutorial
    }
}

struct sheetLevel1: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Spacer()
                Text("LEVEL 1")
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

struct sheetLevelConcluido: View {
    
    @Binding var showNextPhaseSheet: Bool
    
    @Binding var showNext: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Text("LEVEL 1")
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

struct SheetWrapper<Content: View>: UIViewControllerRepresentable {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIHostingController(rootView: content)
        controller.isModalInPresentation = true
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        uiViewController.view.backgroundColor = .clear
    }
}
