//
//  DayDetailsViewController.swift
//  Forecast_Codable
//
//  Created by Karl Pfister on 2/6/22.
//

import UIKit

class DayDetailsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var dayForcastTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentHighLabel: UILabel!
    @IBOutlet weak var currentLowLabel: UILabel!
    @IBOutlet weak var currentDescriptionLabel: UILabel!
    
    //MARK: - Properties
    var days: [Day] = []
    var forcastData: TopLevelDictionary?
    
    //MARK: - View Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayForcastTableView.dataSource = self
        dayForcastTableView.delegate = self
        
        
        NetworkController.fetchDays { forcastData in
            guard let forcastData = forcastData else { return }
            self.forcastData = forcastData
            self.days = forcastData.days
            DispatchQueue.main.async {
                self.updateViews()
                self.dayForcastTableView.reloadData()
            }
        }
    }
    
    func updateViews() {
        let day = days[0]
        cityNameLabel.text = forcastData?.cityName ?? "IDK what to tell you but there's no city here"
        currentTempLabel.text = "\(day.temp)"
        currentHighLabel.text = "\(day.highTemp)"
        currentLowLabel.text = "\(day.lowTemp)"
        currentDescriptionLabel.text = day.weather.description
    }
}

//MARK: - Extenstions
extension DayDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcastData?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as? DayForcastTableViewCell else {return UITableViewCell()}
        
        let day = days[indexPath.row]
        cell.updateViews(day: day)
        
        return cell
    }
}

