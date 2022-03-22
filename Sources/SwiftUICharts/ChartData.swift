//
//  ChartData.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import Foundation

public struct ChartData {
    var nodes: [ChartNode]
    var maxValue: Double
    var minValue: Double
    
    
    public init<N: BinaryInteger>(values:[N]){
        self.init(values: values.map({("",Double($0))}))
    }
    
    public init<N: BinaryFloatingPoint>(values:[N]){
        self.init(values: values.map({("",Double($0))}))
    }
    
    
    public init<N: BinaryInteger>(values:[(String,N)]){
        self.init(values: values.map({($0.0,Double($0.1))}))
    }
    
    public init<N: BinaryFloatingPoint>(values:[(String,N)]){
        self.init(values: values.map({($0.0,Double($0.1))}))
    }
    
    public init(values:[(String,Double)]) {
        var result: [ChartNode] = []
        var maxValue: Double = 0
        var minValue: Double = .infinity
        
        for (index,value) in values.enumerated() {
            result.append(ChartNode(id: index, name: value.0, value: value.1))
            maxValue = max(maxValue, value.1)
            minValue = min(minValue, value.1)
        }
        self.nodes = result
        self.maxValue = maxValue == 0 ? 1 : maxValue
        self.minValue = minValue
    }
    
    
    var count: Int {
        return nodes.count
    }
    
    var pointValues: [Double]{
        nodes.map({$0.value})
    }
    
}

struct ChartNode: Identifiable {
    let id: Int
    let name: String
    let value: Double
    
    var index: Int {
        return id
    }
}
