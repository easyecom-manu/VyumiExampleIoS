//
//  CustomIntegrationViewController.swift
//  VyumiExampleIoS
//
//  Created by Manu Mathew on 22/06/26.
//
import UIKit
import VyumiLiveCalliOS

final class CustomIntegrationViewController: UIViewController, CallInteractionCallback {

    // MARK: - Views

    private let remoteView = UIView()
    private let localView = UIView()

    private let micButton = UIButton(type: .system)
    private let cameraButton = UIButton(type: .system)
    private let flipButton = UIButton(type: .system)
    private let messageButton = UIButton(type: .system)
    private let endCallButton = UIButton(type: .system)

    // MARK: - State

    private var isMicMuted = false
    private var isCameraEnabled = true
    private var isBackCamera = false

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Custom Call"
        view.backgroundColor = .black

        setupUI()
        setupActions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        VyumiLiveCall.joinCall(
            selfView: localView,
            remoteView: remoteView,
            callInteractionCallback: self
        )
    }

    // MARK: - UI

    private func setupUI() {

        remoteView.translatesAutoresizingMaskIntoConstraints = false
        remoteView.backgroundColor = .darkGray

        localView.translatesAutoresizingMaskIntoConstraints = false
        localView.backgroundColor = .lightGray
        localView.layer.cornerRadius = 12
        localView.clipsToBounds = true

        configureButton(micButton, title: "Mic")
        configureButton(cameraButton, title: "Camera")
        configureButton(flipButton, title: "Flip")
        configureButton(messageButton, title: "Chat")

        endCallButton.setTitle("End", for: .normal)
        endCallButton.backgroundColor = .systemRed
        endCallButton.tintColor = .white
        endCallButton.layer.cornerRadius = 25
        endCallButton.translatesAutoresizingMaskIntoConstraints = false

        let controls = UIStackView(arrangedSubviews: [
            micButton,
            cameraButton,
            flipButton,
            messageButton,
            endCallButton
        ])

        controls.axis = .horizontal
        controls.distribution = .fillEqually
        controls.spacing = 12
        controls.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(remoteView)
        view.addSubview(localView)
        view.addSubview(controls)

        NSLayoutConstraint.activate([

            remoteView.topAnchor.constraint(equalTo: view.topAnchor),
            remoteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            remoteView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            remoteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            localView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            localView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            localView.widthAnchor.constraint(equalToConstant: 120),
            localView.heightAnchor.constraint(equalToConstant: 160),

            controls.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            controls.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            controls.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            controls.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureButton(
        _ button: UIButton,
        title: String
    ) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupActions() {
        micButton.addTarget(
            self,
            action: #selector(micTapped),
            for: .touchUpInside
        )

        cameraButton.addTarget(
            self,
            action: #selector(cameraTapped),
            for: .touchUpInside
        )

        flipButton.addTarget(
            self,
            action: #selector(flipTapped),
            for: .touchUpInside
        )

        messageButton.addTarget(
            self,
            action: #selector(messageTapped),
            for: .touchUpInside
        )

        endCallButton.addTarget(
            self,
            action: #selector(endCallTapped),
            for: .touchUpInside
        )
    }

    // MARK: - Actions

    @objc private func micTapped() {
        isMicMuted.toggle()

        VyumiLiveCall.muteMicrophone(
            isMicMuted
        )
    }

    @objc private func cameraTapped() {
        isCameraEnabled.toggle()

        VyumiLiveCall.enableCamera(
            isCameraEnabled
        )
    }

    @objc private func flipTapped() {
        isBackCamera.toggle()

        VyumiLiveCall.useBackCamera(
            isBackCamera
        )
    }

    @objc private func messageTapped() {
        print("Open Messages")
    }

    @objc private func endCallTapped() {
        VyumiLiveCall.endCall()

        navigationController?.popViewController(
            animated: true
        )
    }
    
    
    func onReceivingMessage(message: Message) {
        print("Message:", message.message ?? "")
    }

    func onRemoteMicUpdate(muted: Bool) {
        print("Remote Mic:", muted)
    }

    func onRemoteCameraUpdate(enabled: Bool) {
        print("Remote Camera:", enabled)
    }

    func onCallEnded() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(
                animated: true
            )
        }
    }

    func onPermissionError(message: String) {
        print("Permission Error:", message)
    }

    func onError(message: String) {
        print("Error:", message)
    }

    func onAgentNetworkQuality(quality: Int) {
        print("Network Quality:", quality)
    }
}
