//
//  HomeViewController.swift
//  VyumiExampleIoS
//
//  Created by Manu Mathew on 22/06/26.
//

import UIKit
import VyumiLiveCalliOS

final class HomeViewController: UIViewController, CallSessionCallback {


    private let stackView = UIStackView()

    private let initiateCallButton = UIButton(type: .system)
    private let prebuiltUIButton = UIButton(type: .system)
    private let timeSlotsButton = UIButton(type: .system)
    private let scheduleCallButton = UIButton(type: .system)
    
    private var isPrebuiltFlow = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Vyumi SDK Demo"
        view.backgroundColor = .systemBackground

        setupViews()
        setupActions()
    }

    private func setupViews() {

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        configureButton(
            initiateCallButton,
            title: "Initiate Call"
        )

        configureButton(
            prebuiltUIButton,
            title: "Initiate Call With Prebuilt UI"
        )

        configureButton(
            timeSlotsButton,
            title: "Get Time Slots"
        )

        configureButton(
            scheduleCallButton,
            title: "Schedule Call"
        )

        stackView.addArrangedSubview(initiateCallButton)
        stackView.addArrangedSubview(prebuiltUIButton)
        stackView.addArrangedSubview(timeSlotsButton)
        stackView.addArrangedSubview(scheduleCallButton)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func configureButton(
        _ button: UIButton,
        title: String
    ) {
        button.setTitle(title, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 12
    }

    private func setupActions() {
        initiateCallButton.addTarget(
            self,
            action: #selector(initiateCallTapped),
            for: .touchUpInside
        )

        prebuiltUIButton.addTarget(
            self,
            action: #selector(prebuiltTapped),
            for: .touchUpInside
        )

        timeSlotsButton.addTarget(
            self,
            action: #selector(timeSlotsTapped),
            for: .touchUpInside
        )

        scheduleCallButton.addTarget(
            self,
            action: #selector(scheduleCallTapped),
            for: .touchUpInside
        )
    }

    @objc private func initiateCallTapped() {
        isPrebuiltFlow = false
        
        Task {

            // 1. Initialize SDK (do once)
            await VyumiLiveCall.initialize("258e52a321")

            // 2. Set product URL (Android equivalent)
            VyumiLiveCall.setProductURL(
                "https://www.caratlane.us/glossy-diamod-vanki-ring.html"
            )

            // 3. Build user payload (Android JSONObject equivalent)
            let payload: [String: Any] = [
                "name": "AMAyyu",
                "mobile_no": "4433288130",
                "country_code": "+91"
            ]

            // 4. Make instant call
            await VyumiLiveCall.makeInstantCall(
                payload: payload,
                callType: "video",
                callSessionEvent: self
            )
//        
    }
        

    }

    @objc private func prebuiltTapped() {
        isPrebuiltFlow = true


        Task {

            // 1. Initialize SDK (do once)
            await VyumiLiveCall.initialize("258e52a321")

            // 2. Set product URL (Android equivalent)
            VyumiLiveCall.setProductURL(
                "https://www.caratlane.us/glossy-diamod-vanki-ring.html"
            )

            // 3. Build user payload (Android JSONObject equivalent)
            let payload: [String: Any] = [
                "name": "AMAyyu",
                "mobile_no": "4433288130",
                "country_code": "+91"
            ]

            // 4. Make instant call
            await VyumiLiveCall.makeInstantCall(
                payload: payload,
                callType: "video",
                callSessionEvent: self
            )
//
    }
        
    }

    @objc private func timeSlotsTapped() {
        Task {
            do {
                await VyumiLiveCall.initialize("258e52a321")

                let slots = await VyumiLiveCall.getTimeSlots(
                    timeZone: "Asia/Calcutta"
                )

                print("Get Time Slots")
                print(slots)

            }
        }
    }

    @objc private func scheduleCallTapped() {
        print("Schedule Call")
    }
    
    
    func onRoomReady(message: String) {
        print("onRoomReady", message)
        
        if(isPrebuiltFlow){
            navigationController?.pushViewController(
                PrebuiltUIViewController(),
                animated: true
            )
        }
        else{
                navigationController?.pushViewController(
                    CustomIntegrationViewController(),
                    animated: true
                )
        }
    }
    
    func onAgentNotAvailable(message: String) {
        print("onAgentNotAvailable", message)
    }
    
    func onConnectingToAgent(message: String) {
        print("onConnectingToAgent", message)
    }
    
    func onAgentAssigned(message: String) {
        print("onAgentAssigned", message)
    }
    
    func onError(message: String) {
        print("onError", message)
    }
    
    func onQueueUpdate(message: String, position: Int) {
        print("onQueueUpdate", message)
    }
    
}
