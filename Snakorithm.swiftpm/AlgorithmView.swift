import SwiftUI

struct AlgorithmView: View {
    
    @ObservedObject private var audioManager = AudioManager.shared
    
    var body: some View {
        ZStack {
            Color(hex: "0F6B00")
                .ignoresSafeArea()
            VStack {
                showTitle
                showText
            }
        }
        .navigationBarHidden(true)
    }
    
    var showTitle: some View {
        HStack {
            CustomBackButton()
            Spacer()
            Text("What is an Algorithm?")
                .font(Font.custom("Itim-Regular", size:80))
                .foregroundColor(.white)
                .padding(.top, 40)
            Spacer()
        }
    }
    
    var showText: some View {
        VStack {
            Spacer()
            Text("An algorithm is a series of steps you have to take to solve a certain problem.")
                .font(Font.custom("Itim-Regular", size:40))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            Text("Use this idea to help the snake eat the apples and escape!!!")
                .font(Font.custom("Itim-Regular", size:40))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            NavigationLink(destination: Level1View()) {
                Image("continue-button")
            }
            Spacer()
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
                }
                .padding(20)
            }
        }
    }
}
