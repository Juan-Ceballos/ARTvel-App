//
//  Date+Extensions.swift
//  ARTvel-App
//
//  Created by Juan Ceballos on 10/28/20.
//

import Foundation

extension Date  {
    public func dateString(_ format: String = "EEEE, MMM d, h:mm a") -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
