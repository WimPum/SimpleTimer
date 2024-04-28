//
//  PickerView.swift
//  SimpleTimer
//
//  Created by 虎澤謙 on 2024/04/28.
//

import SwiftUI

struct PickerView: View {
    @Binding var DurationMin: Int
    @Binding var DurationSec: Int
    var body: some View {
        HStack { // ピッカー
            Picker(selection: $DurationMin, label: Text("")){
                ForEach(0..<60, id: \.self) { i in
                    Text("\(i) min").tag(i)
                }
            }
            Picker(selection: $DurationSec, label: Text("")){
                ForEach(0..<60, id: \.self) { i in
                    Text("\(i) sec").tag(i)
                }
            }
        }
    }
}

//#Preview {
//    @State private var dummy1: Int = 1
//    @State private var dummy2: Int = 1
//    PickerView(DurationMin: $dummy1, DurationSec: $dummy2)
//}
