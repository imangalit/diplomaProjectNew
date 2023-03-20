//
//  ViewController.swift
//  diplomaProject
//
//  Created by Имангали on 3/9/23.
//

import UIKit

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

class ViewController: UIViewController {
    
    private var contentView: FirstFloorView = {
        let contentView = FirstFloorView()
        return contentView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "1", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "2", at: 2, animated: true)
        segmentedControl.insertSegment(withTitle: "3", at: 3, animated: true)
        segmentedControl.insertSegment(withTitle: "4", at: 4, animated: true)
        segmentedControl.insertSegment(withTitle: "0", at: 0, animated: true)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        for sview in segmentedControl.subviews {
            for subview in sview.subviews {
                if subview is UILabel {
                    (subview as! UILabel).transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                }
            }
        }
        return segmentedControl
    }()
    
    private let menuView: MenuView = {
        let menuView = MenuView()
        return menuView
    }()
    private var bottomConstraint = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        contentView.isUserInteractionEnabled = true
        contentView.isMultipleTouchEnabled = true

        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognized(_:)))
        contentView.addGestureRecognizer(pinchGestureRecognizer)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        contentView.addGestureRecognizer(panGestureRecognizer)
        
        menuView.addGestureRecognizer(tapRecognizer)

        pinchGestureRecognizer.delegate = self
        panGestureRecognizer.delegate = self
        
        view.addSubview(contentView)
        view.addSubview(segmentedControl)
        view.addSubview(menuView)
        
        setupSubviews()
        menuView.addGestureRecognizer(tapRecognizer)
    }
    
    private func setupSubviews() {
        contentView.center = view.center
        menuView.center = view.center
        
        view.backgroundColor = UIColor.white
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: view.frame.width),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.width * 1.10582771204),
            
            segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            segmentedControl.widthAnchor.constraint(equalToConstant: 100),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            menuView.heightAnchor.constraint(equalToConstant: 500),
        ])
        bottomConstraint = menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 440)
        bottomConstraint.isActive = true
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        contentView.imageView.backgroundColor = UIColor.yellow
        print("YES")
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
        switch gestureRecognizer.state {
            case .began, .changed:
                let translation = gestureRecognizer.translation(in: view)

                var centerX = contentView.center.x + translation.x
                var centerY = contentView.center.y + translation.y

//                let mxX = contentView.frame.width * 1
//                let mnX = view.bounds.width * 1 - contentView.frame.width * 1
//                centerX = max(min(centerX, mxX), mnX)
//
//                let mxY = contentView.frame.height * 1
//                let mnY = view.bounds.height * 1 - contentView.frame.height * 1
//                centerY = max(min(centerY, mxY), mnY)

                contentView.center = CGPoint(x: centerX, y: centerY)
                gestureRecognizer.setTranslation(CGPoint.zero, in: view)
            default:
                break
        }
    }
    
    private var currentState: State = .closed

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewTapped(recognizer:)))
        return recognizer
    }()
    @objc private func popupViewTapped(recognizer: UITapGestureRecognizer) {
        print("YES")
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = 440
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = 440
            }
        }
        transitionAnimator.startAnimation()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
