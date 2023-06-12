//
//  ViewController.swift
//  ChartsTesting
//
//  Created by David Iordan on 6/11/23.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = UIHostingController(rootView: DefaultDonutChartUIView())

        guard let donutChartView = vc.view else { return }

        donutChartView.translatesAutoresizingMaskIntoConstraints = false
        addChild(vc)
        view.addSubview(donutChartView)

        NSLayoutConstraint.activate([
            donutChartView.widthAnchor.constraint(equalTo: view.widthAnchor),
            donutChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            donutChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        vc.didMove(toParent: self)
    }

}

