import SwiftUI

// la grafica della snackbar
struct Snackbar: View {
    let testo: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
            Text(testo)
                .font(.subheadline)
                .bold()
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.black.opacity(0.85))
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

// comparsa, animazione e scomparsa automatica, scritte una volta sola
struct SnackbarModifier: ViewModifier {
    @Binding var visibile: Bool
    let testo: String
    let distanzaDalBasso: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if visibile {
                    Snackbar(testo: testo)
                        .padding(.bottom, distanzaDalBasso)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.easeInOut, value: visibile)
            .onChange(of: visibile) { _, nuovo in
                if nuovo {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        visibile = false
                    }
                }
            }
    }
}

// permette di scrivere .snackbar(...) su qualsiasi vista
extension View {
    func snackbar(_ testo: String, isPresented: Binding<Bool>, distanzaDalBasso: CGFloat = 100) -> some View {
        modifier(SnackbarModifier(visibile: isPresented, testo: testo, distanzaDalBasso: distanzaDalBasso))
    }
}
