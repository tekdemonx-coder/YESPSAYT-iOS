import SwiftUI

struct ContentView: View {
    @State private var destination: AppDestination?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            RadialGradient(colors: [Color(red: 0.08, green: 0.20, blue: 0.16), .black], center: .top, startRadius: 10, endRadius: 600).ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 28).fill(Color.white.opacity(0.04)).frame(width: 120, height: 120)
                    Text("YP").font(.system(size: 48, weight: .black, design: .rounded)).foregroundStyle(.yellow)
                }
                .shadow(color: .green.opacity(0.55), radius: 24)

                Text("YESPSAYT")
                    .font(.system(size: 38, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .green, radius: 12)

                Text("YOLDA HƏMİŞƏ SƏNİNLƏ")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.green)
                    .tracking(2)

                Spacer()

                Button { destination = .login } label: {
                    Text("GİRİŞ").font(.headline).frame(maxWidth: .infinity).padding(.vertical, 17)
                }
                .buttonStyle(NeonButtonStyle(primary: true))

                Button { destination = .register } label: {
                    Text("QEYDİYYAT").font(.headline).frame(maxWidth: .infinity).padding(.vertical, 17)
                }
                .buttonStyle(NeonButtonStyle(primary: false))

                Text("YESPSAYT • iOS")
                    .font(.caption2).foregroundStyle(.white.opacity(0.45)).padding(.top, 12)
                Spacer().frame(height: 24)
            }
            .padding(.horizontal, 28)
        }
        .fullScreenCover(item: $destination) { item in
            NavigationStack {
                WebViewScreen(startURL: item.url)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Bağla") { destination = nil }
                        }
                    }
            }
        }
    }
}

enum AppDestination: Identifiable {
    case login, register
    var id: String { String(describing: self) }
    var url: URL {
        switch self {
        case .login: return URL(string: "https://boltcatdirilma.tekdemonx.workers.dev/")!
        case .register: return URL(string: "https://boltcatdirilma.tekdemonx.workers.dev/register")!
        }
    }
}

struct NeonButtonStyle: ButtonStyle {
    let primary: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(primary ? .black : .green)
            .background(primary ? Color.green : Color.green.opacity(0.08))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.green, lineWidth: 1.5))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .green.opacity(configuration.isPressed ? 0.25 : 0.65), radius: configuration.isPressed ? 8 : 18)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
    }
}
