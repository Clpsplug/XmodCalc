import Foundation

class Settings: ObservableObject {
    @Published var preferredBPM: Int = 120
    @Published var premiumAvailable: Bool = false

    func load() {
        let pref = UserDefaults.standard
        self.preferredBPM = pref.integer(forKey: "preferred_bpm")
        self.premiumAvailable = pref.bool(forKey: "premium_available")
        if self.preferredBPM == 0 {
            self.preferredBPM = 120
        }
    }

    func save() {
        let pref = UserDefaults.standard
        pref.set(self.preferredBPM, forKey: "preferred_bpm")
        pref.set(self.premiumAvailable, forKey: "premium_available")
    }
}
