//
//  FloorView.swift
//  diplomaProject
//
//  Created by Имангали on 3/29/23.
//

import UIKit

class FloorView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10
        return scrollView
    }()
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    var imageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "1 floor"))
        return imageView
    }()
    func changeImage(_ index: Int) {
        imageView.image = UIImage(named: String(index) + " floor")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        scrollView.frame = self.bounds
        scrollView.delegate = self
        scrollView.contentSize = self.bounds.size
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = scrollView.bounds
        
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),
        ])
        layoutIfNeeded()
    }
    var circleLayers = [CAShapeLayer]()
    
    func drawRoom(_ room: Dot) {
        var zoomRect = zoomRectForScale(scale: 1, center: CGPoint(x: imageView.center.x, y: imageView.center.y))
        scrollView.zoom(to: zoomRect, animated: true)
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: room.x, y: room.y),
                                                  radius: 1,
                                                  startAngle: 0,
                                                  endAngle: CGFloat(Double.pi * 2),
                                                  clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.red.cgColor
        contentView.layer.addSublayer(circleLayer)
        circleLayers.append(circleLayer)
        
        zoomRect = zoomRectForScale(scale: 6, center: CGPoint(x: room.x, y: room.y))
        scrollView.zoom(to: zoomRect, animated: true)
        
    }
    func removeCircles() {
        for circleLayer in circleLayers {
            circleLayer.removeFromSuperlayer()
        }
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRectZero
        zoomRect.size.height = contentView.frame.size.height / scale;
        zoomRect.size.width  = contentView.frame.size.width  / scale;
        let newCenter = contentView.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - ((zoomRect.size.width / 2.0));
        zoomRect.origin.y = newCenter.y - ((zoomRect.size.height / 2.0));
        return zoomRect
    }
    func drawPath(_ room1: Dot, _ room2: Dot) {
        
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: room1.x, y: room1.y))
        linePath.addLine(to: CGPoint(x: room2.x, y: room2.y))

        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 2.0

        contentView.layer.addSublayer(lineLayer)
        circleLayers.append(lineLayer)
        
        drawRoom(room1)
        drawRoom(room2)
    }
}
extension FloorView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
}
