//
//  PortfolioViewController.swift
//  PortfolioModule
//
//  Created by J Andrean on 20/06/24.
//

import Foundation
import UIKit
import UIModule

class PortfolioViewController: BaseVC {
    private let donutChartView: DonutChartView = {
        let view = DonutChartView(frame: .init(x: 0, y: 0, width: 300, height: 300))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(donutChartView)
        NSLayoutConstraint.activate {
            donutChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            donutChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            donutChartView.topAnchor.constraint(equalTo: view.topAnchor)
            donutChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
        
        donutChartView.dataEntries = [
            .init(value: 30, label: "Gopay", color: .blue),
            .init(value: 20, label: "Ovo", color: .red),
            .init(value: 50, label: "Dana", color: .green)
        ]
    }
}

class DonutChartView: UIView {
    
    var dataEntries: [DonutChartDataEntry] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set up variables for drawing
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) * 0.4
        let total = dataEntries.reduce(0) { $0 + $1.value }
        
        var startAngle: CGFloat = -CGFloat.pi / 2
        
        // Draw each segment of the donut chart
        for entry in dataEntries {
            let endAngle = startAngle + 2 * .pi * (entry.value / total)
            
            context.setFillColor(entry.color.cgColor)
            context.move(to: center)
            context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context.fillPath()
            
            startAngle = endAngle
            
            // Draw label and percentage
            drawLabelAndPercentage(entry.label, percentage: entry.value / total, startAngle: startAngle - (endAngle - startAngle) / 2, endAngle: endAngle, center: center, radius: radius * 0.75)
        }
    }
    
    private func drawLabelAndPercentage(_ label: String, percentage: CGFloat, startAngle: CGFloat, endAngle: CGFloat, center: CGPoint, radius: CGFloat) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        
        let percentageString = formatter.string(from: NSNumber(value: Double(percentage))) ?? ""
        
        // Calculate label position
        let labelRadius = radius * 0.75
        let labelX = center.x + labelRadius * cos(startAngle + (endAngle - startAngle) / 2)
        let labelY = center.y + labelRadius * sin(startAngle + (endAngle - startAngle) / 2)
        
        let labelAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]
        
        let labelSize = label.size(withAttributes: labelAttributes)
        let labelRect = CGRect(x: labelX - labelSize.width / 2, y: labelY - labelSize.height / 2, width: labelSize.width, height: labelSize.height)
        label.draw(in: labelRect, withAttributes: labelAttributes)
        
        // Calculate percentage position
        let percentageRadius = radius + 20
        let percentageX = center.x + percentageRadius * cos(startAngle + (endAngle - startAngle) / 2)
        let percentageY = center.y + percentageRadius * sin(startAngle + (endAngle - startAngle) / 2)
        
        let percentageAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 12),
            .foregroundColor: UIColor.black
        ]
        
        let percentageSize = percentageString.size(withAttributes: percentageAttributes)
        let percentageRect = CGRect(x: percentageX - percentageSize.width / 2, y: percentageY - percentageSize.height / 2, width: percentageSize.width, height: percentageSize.height)
        percentageString.draw(in: percentageRect, withAttributes: percentageAttributes)
    }
}

struct DonutChartDataEntry {
    var value: CGFloat
    var label: String
    var color: UIColor
}
