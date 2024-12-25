//
//  ViewController.swift
//  MVVM_practice
//
//  Created by Jaehyun Ahn on 12/25/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


import SwiftUI

struct UIViewControllerPreview<ViewController: UIViewController>: UIViewRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        self.viewController = builder()
    }

    func makeUIView(context: Context) -> UIView {
        return viewController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No update logic needed
    }
}
