//
//  DayForcastTableViewCell.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayForcastTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var forcastedHighLabel: UILabel!
    
    // MARK: - Functions
    func updateViews(day: Day) {
        dayNameLabel.text = day.validDate
        forcastedHighLabel.text = "High: \(day.highTemp)"
        iconImageView.image = UIImage(named: day.weather.iconString)
    }
}
