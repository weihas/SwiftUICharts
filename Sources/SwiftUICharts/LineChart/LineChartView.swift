//
//  LineChartView.swift
//  
//
//  Created by WeIHa'S on 2022/3/22.
//

import SwiftUI

public struct LineChartView: View {
    let data: ChartData
    
    @State var touchLocation: CGPoint = .zero
    @State var showLabel: Bool = false
    
    let maxValue: Double
    let minValue: Double
    
    public init(data: ChartData, maxValue: Double? = nil, minvalue: Double? = nil) {
        self.data = data
        self.maxValue = maxValue ?? data.maxValue
        self.minValue = minvalue ?? data.minValue
    }
    
    public var body: some View {
        ZStack(alignment: .trailing){
            Legend(maxValue: maxValue, minValue: minValue)
            Line(data: data, touchLocation: touchLocation, showIndicator: showLabel, maxValue: 5, minValue: minValue)
        }
    }
}

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(data: .init(values: [3.4,1.0,1.8,2.4,2.9,4.0,3.8,3.0]), maxValue: 5  , minvalue: 0)
        
        LineChartView(data: .init(values: [4.0, 2.5]))
    }
}
#endif
