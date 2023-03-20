//
//  DrawViewController.swift
//  diplomaProject
//
//  Created by Имангали on 3/15/23.
//

import UIKit

class DrawViewController: UIViewController {

    let contentView: UIView = {
        let contentView = UIView(frame: UIScreen.main.bounds)
        //contentView.backgroundColor = UIColor.blue
        contentView.isUserInteractionEnabled = true
        contentView.isMultipleTouchEnabled = true
        return contentView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1floor")
        //imageView.backgroundColor = UIColor.systemPink
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    let addRoomButton: UIButton = {
        let addRoomButton = UIButton()
        addRoomButton.setTitle("Add", for: .normal)
        addRoomButton.tintColor = UIColor.red
        addRoomButton.backgroundColor = UIColor.red
        return addRoomButton
    }()
    
    let recView: UIView = {
        let recView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        recView.layer.cornerRadius = 5
        
        recView.backgroundColor = UIColor.orange
        recView.isUserInteractionEnabled = true
        return recView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized(_:)))
        contentView.addGestureRecognizer(pinchGestureRecognizer)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        contentView.addGestureRecognizer(panGestureRecognizer)
        
        let panGestureForRecView = UIPanGestureRecognizer(target: self, action: #selector(handlePanForRecView(_:)))
        recView.addGestureRecognizer(panGestureForRecView)

        pinchGestureRecognizer.delegate = self
        panGestureRecognizer.delegate = self
        panGestureForRecView.delegate = self
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        print("Setup")
        contentView.center = view.center
        imageView.center = contentView.center
        addRoomButton.center = contentView.center
        
        view.backgroundColor = UIColor.white
        view.addSubview(contentView)
        contentView.addSubview(imageView)
        view.addSubview(addRoomButton)
        contentView.addSubview(recView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addRoomButton.translatesAutoresizingMaskIntoConstraints = false
        recView.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: guide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 1.10582771204),
            
            addRoomButton.widthAnchor.constraint(equalToConstant: 40),
            addRoomButton.heightAnchor.constraint(equalToConstant: 40),
            addRoomButton.topAnchor.constraint(equalTo: guide.topAnchor),
            addRoomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            recView.widthAnchor.constraint(equalToConstant: 40),
            recView.heightAnchor.constraint(equalToConstant: 40),
            //recView.topAnchor.constraint(equalTo: imageView.topAnchor),
            //recView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        ])
    }
//    @objc func handlePanForRecView(_ sender: UIPanGestureRecognizer) {
//        guard sender.state == .began else {
//            return
//        }
//
//        let translation = sender.translation(in: self.recView)
//        self.recView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
//        sender.setTranslation(CGPoint.zero, in: self.recView)
//    }
    @objc func handlePanForRecView(_ gestureRecognizer: UIPanGestureRecognizer) {

        print("drag", recView.center)
        guard let gview = gestureRecognizer.view else {
            return
        }
        let translation = gestureRecognizer.translation(in: view)

        if (gview != recView) {
            print("HERE")
        }
        // Обновляем позицию view, которую хотим перетаскивать, на основе текущей позиции жеста
        gview.center = CGPoint(x: gview.center.x + translation.x,
                               y: gview.center.y + translation.y)
        // Сбрасываем перемещение жеста, чтобы следующее перемещение было относительно текущей позиции view
        gestureRecognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func pinchGestureRecognized(_ gestureRecognizer: UIPinchGestureRecognizer) {

        switch gestureRecognizer.state {
           case .began, .changed:
               let scale = gestureRecognizer.scale
               let currentTransform = contentView.transform
               let newTransform = currentTransform.scaledBy(x: scale, y: scale)
               let newScale = newTransform.a

               if newScale < 0.8 || newScale > 5.0 {
                   return
               }

               contentView.transform = newTransform
               gestureRecognizer.scale = 1.0
           default:
               break
           }
    }
    
    @objc func panGestureRecognized(_ gestureRecognizer: UIPanGestureRecognizer) {
        print("pan", recView.center)
        if recView.bounds.contains (gestureRecognizer.location(in: recView)) {
            print("YES")
            return
        }
        switch gestureRecognizer.state {
            case .began, .changed:
                let translation = gestureRecognizer.translation(in: view)
                var centerX = contentView.center.x + translation.x
                var centerY = contentView.center.y + translation.y

                let mxX = contentView.frame.width * 1
                let mnX = view.bounds.width * 1 - contentView.frame.width * 1
                centerX = max(min(centerX, mxX), mnX)

                let mxY = contentView.frame.height * 1
                let mnY = view.bounds.height * 1 - contentView.frame.height * 1
                centerY = max(min(centerY, mxY), mnY)

//                contentView.center = CGPoint(x: centerX, y: centerY)
                gestureRecognizer.setTranslation(CGPoint.zero, in: view)
            default:
                break
        }
    }
    
}

//extension DrawViewController {
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else {
//            return
//        }
//        let location = touch.location(in: recView)
//        if recView.bounds.contains(location) {
//            isDragging = true
//        }
//    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard isDragging, let touch = touches.first else {
//            return
//        }
//        let location = touch.location(in: contentView)
//        recView.frame.origin.x = location.x
//        recView.frame.origin.y = location.y
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isDragging = false
//    }
//
//}

extension DrawViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
