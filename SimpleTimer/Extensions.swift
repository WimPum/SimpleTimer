//
//  Extensions.swift
//  SimpleTimer
//
//  Created by 虎澤謙 on 2024/04/28.
//

import SwiftUI

extension View {
    //iOSバージョンで分岐 リスト背景透明化
    func scrollCBIfPossible() -> some View {
        if #available(iOS 16.0, *) {//iOS16以降ならこっちでリスト透明化
            return self.scrollContentBackground(.hidden)
        } else {
            UITableView.appearance().backgroundColor = UIColor(.clear)
            return self
        }
    }
}
