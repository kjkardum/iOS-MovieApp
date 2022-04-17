//
//  TimeIntervalExtension.swift
//  MovieApp
//
//  Created by Karlo Josip Kardum on 10.04.2022..
//

import Foundation

extension TimeInterval {
    init (hours: Double = 0, minutes: Double = 0, seconds: Double = 0, miliseconds: Int = 0) {
        var totalSeconds: Double = hours * 3600
        totalSeconds += minutes * 60.0
        totalSeconds += seconds * 1.0
        totalSeconds += Double(miliseconds) / 1000.0
        self.init(totalSeconds)
    }
    
    func asStringInterval() -> String {
        var result = ""
        result += Int(self / 3600) != 0 ? String(Int(self / 3600)) + "h " : ""
        result += Int(self / 60) % 60 != 0 ? String(Int(self / 60) % 60) + "m " : ""
        result += Int(self) % 60 != 0 ? String(Int(self) % 60) + "s " : ""
        return result
    }
}
