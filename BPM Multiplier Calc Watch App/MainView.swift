import SwiftUI
import WatchKit

let availableXModsPremium = [
    0.25,0.5,0.75,
    1.0,1.25,1.5,1.75,
    2.0,2.25,2.5,2.75,
    3.0,3.25,3.5,3.75,
    4.0,4.5,
    5.0,5.5,
    6.0,6.5,
    7.0,7.5,
    8.0
]

let availableXMods = [
    1.0,1.5,
    2.0,2.5,
    3.0,3.5,
    4.0,4.5,
    5.0,5.5,
    6.0,6.5,
    7.0,7.5,
    8.0
]

func clampToSupportedValue(value: Int) -> Int{
    return min(999, max(value, 1))
}

func drag(val: Binding<Int>, change: Binding<Int>, callback: (() -> Void)?) -> some Gesture {
    DragGesture(minimumDistance: 10, coordinateSpace: .global).onChanged { e in
        change.wrappedValue = Int(e.translation.width) / 2
        callback?() // WTF: I have to call it here although I access them as binding, why?
    }.onEnded { e in
        val.wrappedValue = clampToSupportedValue(value: val.wrappedValue + Int(e.translation.width) / 2)
        change.wrappedValue = 0
        callback?() // WTF: I have to call it here although I access them as binding, why?
    }
}

func GetRoundedFont(fontSize: CGFloat) -> Font {
    let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    let roundedFont: UIFont
    if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
        roundedFont = UIFont(descriptor: descriptor, size: fontSize)
    } else {
        roundedFont = systemFont
    }
    return Font(roundedFont)
}

struct MainView: View {
    @StateObject private var settings = Settings()
    @State private var bpm: Int = 120
    {
        didSet {
            self.calculateXmod()
        }
    }
    @State private var isSettingsPresented = false
    @State private var xmod: String = "x1.00"
    @State private var result: Int = 120
    @State private var currentDragBPMChange: Int = 0
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .center) {
                ZStack(alignment:.center) {
                    ZStack(alignment:.center) {
                        VStack{
                            HStack{
                                Button(action: {
                                    self.bpm = clampToSupportedValue(value: self.bpm - 5)
                                }) {
                                    Image(systemName: "chevron.left")
                                        .resizable()
                                        .foregroundColor(Color.accentColor)
                                }
                                .buttonStyle(.plain)
                                .frame(width: 10, height: 17, alignment: .leading)
                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                                
                                Text("\(clampToSupportedValue(value: bpm + currentDragBPMChange), specifier: "%03d")")
                                    .font(GetRoundedFont(fontSize: 50))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Button(action: {
                                    self.bpm = clampToSupportedValue(value: self.bpm + 5)
                                }) {
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .foregroundColor(Color.accentColor)
                                }
                                .buttonStyle(.plain)
                                .frame(width: 10, height: 17, alignment: .leading)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                            }
                            Text(xmod)
                                .font(GetRoundedFont(fontSize: 30))
                            Text("\(result, specifier: "%03d")")
                                .font(GetRoundedFont(fontSize: 15))
                        }
                        .focusable()
                        .gesture(drag(val: self.$bpm, change: self.$currentDragBPMChange, callback: self.calculateXmod))
                        .digitalCrownRotation(
                            detent: $bpm, from: 1, through: 999, by: 1,
                            sensitivity: .medium
                        ) { _ in
                            self.calculateXmod()
                        }
                    }
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .frame(maxWidth:.infinity, alignment: .trailing)
                                .foregroundColor(Color.white)
                                .onTapGesture{
                                    isSettingsPresented = true
                                }
                        }
                    }
                }
                
            }
            .navigationTitle("Xmod calc")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView().environmentObject(self.settings)
        }
        .onAppear{
            self.settings.load()
            self.calculateXmod()
        }

    }
        
    private func calculateXmod() {
        var bestXmod = 0.0
        for xm in ((self.settings.premiumAvailable) ? availableXModsPremium : availableXMods).reversed() {
            bestXmod = xm
            if Int(Double(self.bpm) * xm) <= self.settings.preferredBPM {
                break;
            }
        }
        self.result = Int(Double(self.bpm) * bestXmod)
        self.xmod = "x\(String(format: "%.2f", bestXmod))"
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

