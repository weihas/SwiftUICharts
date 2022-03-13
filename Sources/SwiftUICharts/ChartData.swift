//
//  ChartData.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import Foundation

public class ChartData: Identifiable {
    var points: [(name: String,value: Double)]
    var valuesGiven: Bool = false
    var ID = UUID()
    
    public init<N: BinaryFloatingPoint>(points:[N]) {
        self.points = points.map{("", Double($0))}
    }
    public init<N: BinaryInteger>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryFloatingPoint>(values:[(String,N)]){
        self.points = values.map{($0.0, Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryInteger>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        self.valuesGiven = true
    }
    public init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues:[(N,N)]){
        self.points = numberValues.map{(String($0.0), Double($0.1))}
        self.valuesGiven = true
    }
    
    var pointValues: [Double]{
        return points.map({$0.value})
    }
}
