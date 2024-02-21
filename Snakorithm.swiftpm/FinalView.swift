import SwiftUI

struct FinalView: View {
    
    @State var isShowing: Bool = false
    
    @Binding var killLastScene: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "0F6B00")
                .ignoresSafeArea()
            VStack {
                showTitle
                Spacer()
                showText
                Spacer()
                bottomBar
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            killLastScene.toggle()
        }
        .sheet(isPresented: $isShowing) {
            sheetInfos(isShowing: $isShowing)
                .interactiveDismissDisabled(true)
        }
    }
    
    var showTitle: some View {
        HStack {
            Spacer()
            Text("Thank you!!!")
                .font(Font.custom("Itim-Regular", size:80))
                .foregroundColor(.white)
                .padding(.top, 40)
            Spacer()
        }
    }
    
    var showText: some View {
        VStack {
            VStack {
                Text(" Thanks for playing 'Snakorithm', an app where the main goal is to teach the basics of programming for children, in a funny and playful way!")
                    .font(Font.custom("Itim-Regular", size:50))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
        }
    }
    
    var bottomBar: some View {
        HStack {
            NavigationLink(destination: ContentView()) {
                Image("play-again-button")
            }
            .padding(.leading, UIScreen.main.bounds.width/2 - 152.5)
            Spacer()
            Button {
                isShowing = true
            } label: {
                Image("comment-info 1")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 20)
            }
        }
        .padding(.bottom, 20)
    }
    struct CustomBackButton: View {
        @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
        
        var body: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image("back-arrow 1")
                }
                .padding(20)
            }
        }
    }
}

struct sheetInfos: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color(hex: "17A600")
            VStack {
                Spacer()
                Text("Created by: Felipe Peixoto")
                    .font(Font.custom("Itim-Regular", size:50))
                    .foregroundColor(.white)
                Spacer()
                VStack {
                    // Add your scrollable content here
                    Text("Icons:")
                        .font(Font.custom("Itim-Regular", size:25))
                        .foregroundColor(.white)
                    Text("  flaticon.com")
                        .font(Font.custom("Itim-Regular", size:25))
                        .foregroundColor(.white)
                    Text("Music & Sounds:")
                        .font(Font.custom("Itim-Regular", size:25))
                        .foregroundColor(.white)
                    Text("Background music: Piano bass drums background loop, by: Valo")
                        .font(Font.custom("Itim-Regular", size:25))
                        .foregroundColor(.white)
                    Text("Correct Answer / That's Right!, by: Beetlemuse")
                        .font(Font.custom("Itim-Regular", size:25))
                        .foregroundColor(.white)
                    Text("Playing Card Slide Left, by: el_boss")
                        .font(Font.custom("Itim-Regular", size:25))
                        .foregroundColor(.white)
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
