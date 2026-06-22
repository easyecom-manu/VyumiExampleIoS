//
//  PrebuiltUIViewController.swift
//  VyumiExampleIoS
//
//  Created by Manu Mathew on 22/06/26.
//

import UIKit
import VyumiLiveCalliOS

final class PrebuiltUIViewController: UIViewController {

    private var didOpenCall = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard !didOpenCall else { return }
        didOpenCall = true

        VyumiPrebuildCall.shared.initCall(
            from: self,
            callback: self
        )
    }
}

extension PrebuiltUIViewController: VyumiLiveCallCallback {

    func onCallEnded() {
        navigationController?.popViewController(animated: true)
    }

    func onError() {
        navigationController?.popViewController(animated: true)
    }
}
