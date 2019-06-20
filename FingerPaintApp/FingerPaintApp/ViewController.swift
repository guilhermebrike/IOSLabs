//
//  ViewController.swift
//  FingerPaintApp
//
//  Created by Derrick Park on 2018-05-22.
//  Copyright © 2018 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let canvasView = CanvasView(frame: CGRect(x: 0, y: 0, width: 375, height: 734))
    override func viewDidLoad() {
		super.viewDidLoad()
        view.addSubview(canvasView)
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
	}
}

