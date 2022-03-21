//
//  IndicatorPoint.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        Circle()
            .stroke(Color.pink, lineWidth: 4)
            .frame(width: 14, height: 14)
            .background(Color.white)
            .shadow(radius: 6)
    }
}

#if DEBUG
struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
#endif
