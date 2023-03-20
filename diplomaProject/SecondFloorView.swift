//
//  SecondFloorView.swift
//  diplomaProject
//
//  Created by Имангали on 3/17/23.
//

import UIKit

class SecondFloorView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1floor")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(imageView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    private func drawRooms() {
        
        var startPoint: CGPoint = CGPoint(x: 0, y: 0)
        var endPoint = CGPoint(x: 100, y: 100)
        
        for room in rooms {
            room.x *= frame.width / 271.29
            room.y *= frame.width * 1.10582771204 / 300.0
            room.x += imageView.frame.origin.x
            room.y += imageView.frame.origin.y
            
            if (room.id == "room1") {
                startPoint = CGPoint(x: room.x, y: room.y)
            }
            if (room.id == "room2") {
                endPoint = CGPoint(x: room.x, y: room.y)
            }
        }
    
        drawPath(startPoint, endPoint)
        
        for room in rooms {
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: room.x, y: room.y),
                                                      radius: 1,
                                                      startAngle: 0,
                                                      endAngle: CGFloat(Double.pi * 2),
                                                      clockwise: true)
            let circleLayer = CAShapeLayer()
            circleLayer.path = circlePath.cgPath
            circleLayer.fillColor = UIColor.orange.cgColor
            layer.addSublayer(circleLayer)
        }
    }
    
    private func drawPath(_ startPoint: CGPoint, _ endPoint: CGPoint) {
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)

        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = UIColor.green.cgColor
        lineLayer.lineWidth = 2.0

        layer.addSublayer(lineLayer)
    }
}
