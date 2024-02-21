import SwiftUI
import AVFoundation


extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    
    var audioPlayer: AVAudioPlayer?
    
    @Published var isPlaying = false
    @Published var volume: Float = 0.7 {
        didSet {
            audioPlayer?.volume = volume
        }
    }
    
    private init() {
        setupAudioPlayer()
    }
    
    private func setupAudioPlayer() {
        guard let path = Bundle.main.path(forResource: "background_music", ofType: "mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Reprodução contínua
            audioPlayer?.volume = volume
        } catch {
            print("Erro ao carregar o arquivo de áudio: \(error.localizedDescription)")
        }
    }
    
    func toggleAudio() {
        if isPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isPlaying.toggle()
    }
    
    func playAudio() {
        if isPlaying {
            return
        }
        isPlaying = true
        audioPlayer?.play()
        return
    }
}


struct ContentView: View {
    
    @ObservedObject private var audioManager = AudioManager.shared
    
    @State private var font: Font?
    
    let snakeImage: UIImage = UIImage(named: "001-snake")!

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "0F6B00")
                    .ignoresSafeArea()
                VStack {
                    showTitle
                        .padding(30)
                    Spacer()
                    bottomPart
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                audioManager.playAudio()
            }
        }
        .task {
            getFont(for: 120)
        }
       .navigationViewStyle(StackNavigationViewStyle())
       .navigationBarHidden(true)
    }
    
    var showTitle: some View {
        VStack {
            HStack {
                Spacer()
                Image("snake-title")
                    .padding(.trailing, -85)
                Text("NAKORITHM")
                    .font(font)
                    .foregroundColor(.white)
                Spacer()
            }
            Text("Use this app in landscape mode for better experience")
                .foregroundColor(.white)
                .font(.system(size:30))
        }
    }
    
    var bottomPart: some View {
        HStack {
//            VStack {
//                Spacer()
//                Image("001-snake")
//            }
            Image("001-snake")
                .offset(y: UIScreen.main.bounds.height/2 - snakeImage.size.height / 1.075)
            Spacer()
            VStack {
                HStack {
                    Image("apple-1")
                    Image("apple-2")
                }
                Image("apple-3")
            }
            Spacer()
            VStack {
                Spacer()
                NavigationLink(destination: AlgorithmView()) {
                    Image("play-button")
                }
                .padding(50)
                .padding(.trailing, 50)
            }
            Spacer()
        }
    }
    
    
    
    func getFont(for size: CGFloat) {
        guard let cfURL = Bundle.main.url(forResource: "Itim-Regular", withExtension: ".ttf") else {
            return
        }
        CTFontManagerRegisterFontsForURL(cfURL as CFURL, .process, nil)
        
        let uiFont = UIFont(name: "Itim-Regular", size: size)
        
        font = Font(uiFont ?? UIFont())
    }
}
