//
//  BarChartView.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

public struct BarChartView : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    private let data: ChartData
    private let title: String
    private let legend: String?
    private let cornerImage: Image?
    private let valueSpecifier: String
    
    @State private var touchLocation: Double = -1.0
    @State private var showValue: Bool = false
    @State private var showLabelValue: Bool = false
    
    @State private var currentValue: Double = 0 {
        didSet{
            if oldValue != self.currentValue && self.showValue {
                HapticFeedback.playSelection()
            }
        }
    }
    
    public init(data: ChartData, title: String, legend: String?, dropShadow: Bool? = true, cornerImage: Image? = Image(systemName: "waveform.path.ecg"), valueSpecifier: String = "%.1f"){
        self.data = data
        self.title = title
        self.legend = legend
        self.cornerImage = cornerImage
        self.valueSpecifier = valueSpecifier
    }
    
    public var body: some View {
        GeometryReader{ geometry in
            let width = geometry.frame(in: .local).width
            ZStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(showValue ? "\(self.currentValue)" : self.title)
                            .font(.headline)
                        Spacer()
                        self.cornerImage
                            .imageScale(.large)
                    }
                    .padding()
                    
                    BarChartRow(data: data.points.map({$0.value}), touchLocation: $touchLocation, showValue: $showValue, showLabelValue: $showLabelValue, cellColor: .orange, currentValue: $currentValue, width: width)
                        .frame(minHeight: width)

                    
                    if legend != nil && !showLabelValue{
                        Text(legend!)
                            .font(.headline)
                            .padding()
                    }else if showLabelValue, let name = getCurrentValue().name  {
                        LabelView(arrowOffset: getArrowOffset(touchLocation: touchLocation, with: width ),
                                  title: name)
                            .offset(x: getLabelViewOffset(touchLocation: touchLocation, with: width), y: -6)
                    }
                }
            }
            .gesture(DragGesture()
                        .onChanged(
                            { value in
                                touchLocation = value.location.x/geometry.size.width
                                showValue = true
                                showLabelValue = true
                                currentValue = getCurrentValue().value
                            })
                     
                        .onEnded(
                            { value in
                                self.showValue = false
                                self.showLabelValue = false
                                self.touchLocation = -1
                            })
            )
            .padding()
        }
    }
    
    private func getArrowOffset(touchLocation: Double, with width: Double) -> Double {
        let realLoc = (self.touchLocation * width) - 50
        if realLoc < 10 {
            return realLoc - 10
        }else if realLoc > width-110 {
            return realLoc - width + 110
        } else {
            return 0
        }
    }
    
    private func getLabelViewOffset(touchLocation:CGFloat, with width: Double) -> Double {
        return min(width-110 , max(10,(self.touchLocation * width) - 50))
    }
    
    
    private func getCurrentValue() -> (name: String,value: Double) {
        guard self.data.points.count > 0 else { return ("",0) }
        let index = max(0,min(self.data.points.count-1, Int(floor(self.touchLocation * Double(self.data.points.count)))))
        return self.data.points[index]
    }
}




//Xcode13 bug cause huge memory
struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(data: TestData.values ,
                     title: "Model 3 sales",
                     legend: "Quarterly",
                     valueSpecifier: "%.0f")
    }
}
