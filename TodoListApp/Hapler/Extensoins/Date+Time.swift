//
//  Date+Time.swift
//  TodoListApp
//
//  Created by Have Dope on 31.08.2024.
//

import Foundation

extension Date {
    static func randomFutureDate(daysAhead: Int = 365) -> Date {
        let today = Date()
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let currentComponents = calendar.dateComponents([.year, .month, .day], from: today)
        
        let randomDays = Int.random(in: 0...daysAhead)
        let randomMonths = Int.random(in: 0...12)
        let randomYears = Int.random(in: 0...2)
        
        var newDateComponents = DateComponents()
        newDateComponents.year = currentComponents.year! + randomYears
        newDateComponents.month = currentComponents.month! + randomMonths
        newDateComponents.day = currentComponents.day! + randomDays
        
        return calendar.date(from: newDateComponents) ?? today
    }
    
    static func randomTime() -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let randomHour = Int.random(in: 0...23)
        let randomMinute = Int.random(in: 0...59)
        
        var timeComponents = DateComponents()
        timeComponents.hour = randomHour
        timeComponents.minute = randomMinute
        
        // Возвращаем текущее время с заданными часами и минутами, но сегодняшней датой
        return calendar.date(from: timeComponents) ?? Date()
    }
    
    // Форматирование времени для отображения
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    // Форматирование даты для отображения в "dd-MM-yyyy"
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
}
