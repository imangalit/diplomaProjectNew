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
    private var floor0View: FloorView = {
        let floorView = FloorView()
        floorView.changeImage(0)
        return floorView
    }()
    private var floor1View: FloorView = {
        let floorView = FloorView()
        floorView.changeImage(1)
        floorView.isHidden = true
        return floorView
    }()
    private var floor2View: FloorView = {
        let floorView = FloorView()
        floorView.changeImage(2)
        floorView.isHidden = true
        return floorView
    }()
    private var floor3View: FloorView = {
        let floorView = FloorView()
        floorView.changeImage(3)
        floorView.isHidden = true
        return floorView
    }()
    private var floor4View: FloorView = {
        let floorView = FloorView()
        floorView.changeImage(4)
        floorView.isHidden = true
        return floorView
    }()
    private var floor5View: FloorView = {
        let floorView = FloorView()
        floorView.changeImage(5)
        floorView.isHidden = true
        return floorView
    }()
    var floorViewModel = FloorViewModel()
    
    private let menuView: MenuView = {
        let menuView = MenuView()
        return menuView
    }()
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: " 1 ", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: " 2 ", at: 2, animated: true)
        segmentedControl.insertSegment(withTitle: " 3 ", at: 3, animated: true)
        segmentedControl.insertSegment(withTitle: " 4 ", at: 4, animated: true)
        segmentedControl.insertSegment(withTitle: " 5 ", at: 5, animated: true)
        segmentedControl.insertSegment(withTitle: " 0 ", at: 0, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(red: 0.102, green: 0.368, blue: 0.613, alpha: 1)
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.selectedSegmentTintColor = UIColor.white
        segmentedControl.layer.borderWidth = 1
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)

        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.082, green: 0.308, blue: 0.517, alpha: 1)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        
        return segmentedControl
    }()
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        floor0View.isHidden = true
        floor1View.isHidden = true
        floor2View.isHidden = true
        floor3View.isHidden = true
        floor4View.isHidden = true
        floor5View.isHidden = true
        switch sender.selectedSegmentIndex {
            case 0:
                floor0View.isHidden = false
            case 1:
                floor1View.isHidden = false
            case 2:
                floor2View.isHidden = false
            case 3:
                floor3View.isHidden = false
            case 4:
                floor4View.isHidden = false
            case 5:
                floor5View.isHidden = false
            default:
                break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floor0View)
        view.addSubview(floor1View)
        view.addSubview(floor2View)
        view.addSubview(floor3View)
        view.addSubview(floor4View)
        view.addSubview(floor5View)
        view.addSubview(segmentedControl)
        view.addSubview(menuView)
        view.backgroundColor = UIColor.white
        
        menuView.searchBar.delegate = self
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self

        setupConstraints()
        menuView.setupConstraints()
        floor0View.setupConstraints()
        floor1View.setupConstraints()
        floor2View.setupConstraints()
        floor3View.setupConstraints()
        floor4View.setupConstraints()
        floor5View.setupConstraints()
        floorViewModel.initRooms(floor0View.frame.width, floor0View.imageView.frame.origin.x, floor0View.imageView.frame.origin.y)
        menuView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        menuView.makeRouteButton.addTarget(self, action: #selector(makeRoutePressed), for: .touchUpInside)
        menuView.menuTopView.addGestureRecognizer(panRecognizer)
        segmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        for case let button as UIButton in menuView.categoryScrollView.subviews {
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        var str = title
        str = str.replacingOccurrences(of: "Кабинет", with: "r")
        str = str.replacingOccurrences(of: "Туалет М", with: "wm")
        str = str.replacingOccurrences(of: "Туалет Ж", with: "ww")
        str = str.replacingOccurrences(of: "Библиотека", with: "lb")
        str = str.replacingOccurrences(of: "Коворкинг", with: "cw")
        str = str.replacingOccurrences(of: "Буфет", with: "bf")
        str = str.replacingOccurrences(of: "Гардероб", with: "wd")
        menuView.searchBar.text = str
        menuView.searchBar.becomeFirstResponder()
        searchBar(menuView.searchBar, textDidChange: str)
        menuView.searchBar.didChangeValue(forKey: str)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private var bottomOffset: CGFloat = -280
    private var bottomConstraint = NSLayoutConstraint()
    private var filteredData: [[Dot]] = [[],[],[],[],[],[],[]]
    private var isSearching = false
    private var makingRoute = 0
    private var firstRoom: Dot = Dot(name: "nil", x: 0, y: 0, connected: [])
    private var secondRoom: Dot = Dot(name: "nil", x: 0, y: 0, connected: [])
    
    private func setupConstraints() {
        bottomOffset += view.frame.height
        menuView.translatesAutoresizingMaskIntoConstraints = false
        floor0View.translatesAutoresizingMaskIntoConstraints = false
        floor1View.translatesAutoresizingMaskIntoConstraints = false
        floor2View.translatesAutoresizingMaskIntoConstraints = false
        floor3View.translatesAutoresizingMaskIntoConstraints = false
        floor4View.translatesAutoresizingMaskIntoConstraints = false
        floor5View.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.heightAnchor.constraint(equalToConstant: view.frame.height - 100),
            
            floor0View.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floor0View.topAnchor.constraint(equalTo: view.topAnchor),
            floor0View.heightAnchor.constraint(equalToConstant: view.frame.height),
            floor0View.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            floor1View.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floor1View.topAnchor.constraint(equalTo: view.topAnchor),
            floor1View.heightAnchor.constraint(equalToConstant: view.frame.height),
            floor1View.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            floor2View.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floor2View.topAnchor.constraint(equalTo: view.topAnchor),
            floor2View.heightAnchor.constraint(equalToConstant: view.frame.height),
            floor2View.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            floor3View.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floor3View.topAnchor.constraint(equalTo: view.topAnchor),
            floor3View.heightAnchor.constraint(equalToConstant: view.frame.height),
            floor3View.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            floor4View.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floor4View.topAnchor.constraint(equalTo: view.topAnchor),
            floor4View.heightAnchor.constraint(equalToConstant: view.frame.height),
            floor4View.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            floor5View.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floor5View.topAnchor.constraint(equalTo: view.topAnchor),
            floor5View.heightAnchor.constraint(equalToConstant: view.frame.height),
            floor5View.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 200),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        bottomConstraint = menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomOffset)
        bottomConstraint.isActive = true
        view.layoutIfNeeded()
    }
    
    private var currentState: State = .closed
    private var runningAnimators = [UIViewPropertyAnimator]()
    private var animationProgress = [CGFloat]()

    private lazy var panRecognizer: InstantPanGestureRecognizer = {
       let recognizer = InstantPanGestureRecognizer()
       recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
       return recognizer
    }()
    
    @objc func makeRoutePressed() {
        makingRoute = 1
        self.menuView.searchBar.placeholder = "Я нахожусь"
        animateTransitionIfNeeded(to: State.open, duration: 1)
    }
    
    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
            
        guard runningAnimators.isEmpty else { return }
        
        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.menuView.hideAndShow("open")
            case .closed:
                self.bottomConstraint.constant = self.bottomOffset
                self.menuView.hideAndShow("close")
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
                default:
                    ()
            }
            
            switch self.currentState {
                case .open:
                    self.bottomConstraint.constant = 0
                case .closed:
                    self.bottomConstraint.constant = self.bottomOffset
            }
            
            self.runningAnimators.removeAll()
            
        }
        
        transitionAnimator.startAnimation()

        runningAnimators.append(transitionAnimator)
        
    }
    
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            
            // start the animations
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1)
            
            // pause all animations, since the next event may be a pan changed
            runningAnimators.forEach { $0.pauseAnimation() }
            
            // keep track of each animator's progress
            animationProgress = runningAnimators.map { $0.fractionComplete }
            
        case .changed:
            
            // variable setup
            let translation = recognizer.translation(in: menuView)
            var fraction = -translation.y / (bottomOffset)
            
            // adjust the fraction for the current state and reversed state
            if currentState == .open { fraction *= -1 }
            if runningAnimators[0].isReversed { fraction *= -1 }
            
            // apply the new fraction
            for (index, animator) in runningAnimators.enumerated() {
                animator.fractionComplete = fraction + animationProgress[index]
            }
            
        case .ended:
            
            // variable setup
            let yVelocity = recognizer.velocity(in: menuView).y
            let shouldClose = yVelocity > 0
            // if there is no motion, continue all animations and exit early
            if yVelocity == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
                break
            }
            
            // reverse the animations based on their current state and pan motion
            switch currentState {
            case .open:
                if !shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .closed:
                if shouldClose && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldClose && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }
            
            // continue all animations
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
            
        default:
            ()
        }
    }
}

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData[0].removeAll()
        self.filteredData[1].removeAll()
        self.filteredData[2].removeAll()
        self.filteredData[3].removeAll()
        self.filteredData[4].removeAll()
        self.filteredData[5].removeAll()

        guard searchText != "" || searchText != " " else {
            print("Empty Search")
            return
        }
        if(searchBar.text == "") {
            isSearching = false
        }
        else {
            isSearching = true
            filteredData[0] = floorViewModel.getFloorRooms(0).filter({$0.name.lowercased().contains(searchBar.text?.lowercased() ?? "")})
            filteredData[1] = floorViewModel.getFloorRooms(1).filter({$0.name.lowercased().contains(searchBar.text?.lowercased() ?? "")})
            filteredData[2] = floorViewModel.getFloorRooms(2).filter({$0.name.lowercased().contains(searchBar.text?.lowercased() ?? "")})
            filteredData[3] = floorViewModel.getFloorRooms(3).filter({$0.name.lowercased().contains(searchBar.text?.lowercased() ?? "")})
            filteredData[4] = floorViewModel.getFloorRooms(4).filter({$0.name.lowercased().contains(searchBar.text?.lowercased() ?? "")})
            filteredData[5] = floorViewModel.getFloorRooms(5).filter({$0.name.lowercased().contains(searchBar.text?.lowercased() ?? "")})
        }
        menuView.tableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if(currentState == State.closed) {
            animateTransitionIfNeeded(to: State.open, duration: 1)
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section) Этаж"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredData[section].count
        }
        else {
            return floorViewModel.getFloorRooms(section).count
        }
    }
    func convertName(_ name: String) -> String {
        var str = name
        str = str.replacingOccurrences(of: "r", with: " Кабинет ")
        str = str.replacingOccurrences(of: "ww", with: " Туалет женский ")
        str = str.replacingOccurrences(of: "wm", with: " Туалет мужской ")
        str = str.replacingOccurrences(of: "lb", with: " Библиотека ")
        str = str.replacingOccurrences(of: "cw", with: " Коворкинг ")
        str = str.replacingOccurrences(of: "bf", with: " Буфет ")
        str = str.replacingOccurrences(of: "wd", with: " Гардероб ")
        
        str = str.replacingOccurrences(of: "Abl", with: " Абылай хан ")
        str = str.replacingOccurrences(of: "Pan", with: " Панфилов ")
        str = str.replacingOccurrences(of: "Tol", with: " Толе би ")
        str = str.replacingOccurrences(of: "Kaz", with: " Казыбек би ")
        
        return str
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 0.102, green: 0.368, blue: 0.613, alpha: 1)
        cell.textLabel?.textColor = UIColor(red: 0.631, green: 0.725, blue: 0.808, alpha: 1)
        if isSearching {
            cell.textLabel?.text = convertName(filteredData[indexPath.section][indexPath.row].name)
        }
        else {
            cell.textLabel?.text = convertName(floorViewModel.getFloorRooms(indexPath.section)[indexPath.row].name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedRoom: Dot
        if isSearching {
            selectedRoom = filteredData[indexPath.section][indexPath.row]
        }
        else {
            selectedRoom = floorViewModel.getFloorRooms(indexPath.section)[indexPath.row]
        }
        if(makingRoute == 1) {
            self.firstRoom = selectedRoom
            self.makingRoute = 2
            menuView.searchBar.searchTextField.text = ""
            menuView.searchBar.becomeFirstResponder()
            searchBarTextDidBeginEditing(menuView.searchBar)
            menuView.searchBar.placeholder = "До"
            menuView.tableView.reloadData()
        }
        else if(makingRoute == 2) {
            self.secondRoom = selectedRoom
            self.makingRoute = 0
            
            removeAllCircles()
            
            findPath(firstRoom, secondRoom)
            
            segmentedControl.selectedSegmentIndex = floorViewModel.getFloorOfDot(firstRoom)
            segmentedControl.sendActions(for: .valueChanged)
            
            self.menuView.searchBar.placeholder = "Найти"
            animateTransitionIfNeeded(to: State.closed, duration: 1)
        }
        else {
            animateTransitionIfNeeded(to: State.closed, duration: 1)
            menuView.searchBar.searchTextField.text = convertName(selectedRoom.name)
            
            removeAllCircles()
            
            segmentedControl.selectedSegmentIndex = floorViewModel.getFloorOfDot(selectedRoom)
            segmentedControl.sendActions(for: .valueChanged)
            
            let floor = floorViewModel.getFloorOfDot(selectedRoom)
            if floor == 0 { floor0View.drawRoom(selectedRoom) }
            else if floor == 1 { floor1View.drawRoom(selectedRoom) }
            else if floor == 2 { floor2View.drawRoom(selectedRoom) }
            else if floor == 3 { floor3View.drawRoom(selectedRoom) }
            else if floor == 4 { floor4View.drawRoom(selectedRoom) }
            else if floor == 5 { floor5View.drawRoom(selectedRoom) }
        }
    }
    func removeAllCircles() {
        floor0View.removeCircles()
        floor1View.removeCircles()
        floor2View.removeCircles()
        floor3View.removeCircles()
        floor4View.removeCircles()
        floor5View.removeCircles()
    }
    func findPath(_ from: Dot, _ to: Dot) {
        let path = floorViewModel.getPath(from, to)
        for index in 0..<path.count - 1 {
            let floor0 = floorViewModel.getFloorOfDot(path[index])
            let floor1 = floorViewModel.getFloorOfDot(path[index + 1])

            if floor0 != floor1 { continue }
            
            if floor0 == 0 { floor0View.drawPath(path[index], path[index + 1]) }
            else if floor0 == 1 { floor1View.drawPath(path[index], path[index + 1]) }
            else if floor0 == 2 { floor2View.drawPath(path[index], path[index + 1]) }
            else if floor0 == 3 { floor3View.drawPath(path[index], path[index + 1]) }
            else if floor0 == 4 { floor4View.drawPath(path[index], path[index + 1]) }
            else if floor0 == 5 { floor5View.drawPath(path[index], path[index + 1]) }
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
