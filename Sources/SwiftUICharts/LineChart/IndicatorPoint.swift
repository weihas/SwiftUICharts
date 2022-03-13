//
//  IndicatorPoint.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.pink)
            Circle()
                .stroke(Color.white, style: StrokeStyle(lineWidth: 4))
        }
        .frame(width: 14, height: 14)
        .shadow(color: .gray, radius: 6, x: 0, y: 6)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
