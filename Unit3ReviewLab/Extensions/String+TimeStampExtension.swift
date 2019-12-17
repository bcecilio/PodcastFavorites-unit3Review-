//
//  String+TimeStamp.swift
//  Unit3ReviewLab
//
//  Created by Brendon Cecilio on 12/17/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

extension String {
    
    static func getISOFormatter() -> ISO8601DateFormatter {
        
        // returns an ISO8601DateFormatter.
        
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.timeZone = .current
        isoDateFormatter.formatOptions = [
            .withInternetDateTime,
            .withFullDate,
            .withFullTime,
            .withFractionalSeconds, // must have this option
            .withColonSeparatorInTimeZone
        ]
        return isoDateFormatter
    }
    
    // THIS EXTENSION CREATES A TIME STAMP! - a date and time for the object.

    
    static func getISOTimestamp() -> String {
        let isoDateFormatter = getISOFormatter()
        let timestamp = isoDateFormatter.string(from: Date()) // Gets us the current date and time.
        return timestamp
    }
    
    func convertISODate() -> String {
        let isoDateFormatter = String.getISOFormatter()
        guard let date = isoDateFormatter.date(from: self) else {
            return self
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d yyyy, h:mm a"
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func isoStringToDate() -> Date {
        let isoDateFormatter = String.getISOFormatter()
        guard let date = isoDateFormatter.date(from: self) else {
            return Date()
        }
        return date
    }
}
