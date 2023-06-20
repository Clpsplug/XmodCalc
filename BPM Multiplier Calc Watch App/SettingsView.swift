import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var settings: Settings

    @State private var preferredBPM: Int = 0
    @State private var premiumAvailable: Bool = false

    @State private var currentChange: Int = 0

    var body: some View {
        VStack {
            Text("Your preferred BPM")
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 18))
                .focusable()
                .multilineTextAlignment(.center)
            HStack {
                Button(action: {
                    self.preferredBPM = clampToSupportedValue(value: self.preferredBPM - 5)
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .foregroundColor(Color.accentColor)
                }
                .buttonStyle(.plain)
                .frame(width: 10, height: 17, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))

                Text(
                    "\(clampToSupportedValue(value: self.preferredBPM + self.currentChange), specifier: "%03d")"
                )
                .font(GetRoundedFont(fontSize: 50))
                .frame(maxWidth: .infinity, alignment: .center)
                Button(action: {
                    self.preferredBPM = clampToSupportedValue(value: self.preferredBPM + 5)
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .foregroundColor(Color.accentColor)
                }
                .buttonStyle(.plain)
                .frame(width: 10, height: 17, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
            }
            Toggle("Playing on Premium", isOn: $premiumAvailable)
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
        }
        .gesture(drag(val: self.$preferredBPM, change: self.$currentChange, callback: nil))
        .padding()
        .onAppear {
            self.preferredBPM = settings.preferredBPM
            self.premiumAvailable = settings.premiumAvailable
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                backButton
            }
        }
        .digitalCrownRotation(
            detent: $preferredBPM, from: 1, through: 999, by: 1,
            sensitivity: .medium
        ) { _ in
            self.settings.preferredBPM = self.preferredBPM
        } onIdle: {
        }
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
            self.settings.premiumAvailable = self.premiumAvailable
            self.settings.save()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.accentColor)
                Text("Settings").font(.system(size: 16)).foregroundColor(Color.accentColor)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
