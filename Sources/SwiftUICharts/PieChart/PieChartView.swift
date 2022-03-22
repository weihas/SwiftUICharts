//
//  PieChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var data: [Double]
    public var title: String
    public var legend: String?
    public var dropShadow: Bool
    public var valueSpecifier:String
    
    @State private var showValue = false
    @State private var currentValue: Double = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
                HapticFeedback.playSelection()
            }
        }
    }
    
    var backgroundColor: Color {
        colorScheme == .dark ? Color.black : Color.white
    }
    
    var foreColor: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    
    public init(data: [Double], title: String, legend: String? = nil, dropShadow: Bool? = true, valueSpecifier: String? = "%.1f"){
        self.data = data
        self.title = title
        self.legend = legend
        self.dropShadow = dropShadow!
        self.valueSpecifier = valueSpecifier!
    }
    
    public var body: some View {
        Rectangle()
            .fill(backgroundColor)
            .cornerRadius(20)
            .shadow(radius: self.dropShadow ? 12 : 0)
            .overlay(
                VStack(alignment: .leading){
                    HStack{
                        if(!showValue){
                            Text(title)
                                .font(.headline)
                        }else{
                            Text("\(currentValue, specifier: valueSpecifier)")
                                .font(.headline)
                        }
                        Spacer()
                        Image(systemName: "chart.pie.fill")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                    }.padding()
                    PieChartRow(data: data, backgroundColor: backgroundColor, accentColor: .orange, showValue: $showValue, currentValue: $currentValue)
                        .foregroundColor(.white).padding(self.legend != nil ? 0 : 12).offset(y:self.legend != nil ? 0 : -10)
                    if(self.legend != nil) {
                        Text(self.legend!)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                }
            )
    }
}

#if DEBUG
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        PieChartView(data:[56,78,53,65,54], title: "Title", legend: "Legend")
    }
}
#endif
