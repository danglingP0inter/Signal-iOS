//
// Copyright 2023 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import LibSignalClient
import SignalServiceKit
import SignalUI

protocol LinkDeviceViewControllerDelegate: AnyObject {
    func expectMoreDevices()
}

class LinkDeviceViewController: OWSViewController {

    weak var delegate: LinkDeviceViewControllerDelegate?

    private lazy var scanningInstructionsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(
            "LINK_DEVICE_SCANNING_INSTRUCTIONS",
            comment: "QR Scanning screen instructions, placed alongside a camera view for scanning QR Codes"
        )
        label.textColor = Theme.secondaryTextAndIconColor
        label.font = .dynamicTypeBody2
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    var selectedAttachment: ImagePickerAttachment?

    private var hasShownEducationSheet = false

    private lazy var qrCodeScanViewController = QRCodeScanViewController(
        appearance: .framed,
        showUploadPhotoButton: FeatureFlags.biometricLinkedDeviceFlow
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        title = CommonStrings.scanQRCodeTitle

#if TESTABLE_BUILD
        navigationItem.rightBarButtonItem = .init(
            title: LocalizationNotNeeded("ENTER"),
            style: .plain,
            target: self,
            action: #selector(manuallyEnterLinkURL)
        )
#endif
        qrCodeScanViewController.delegate = self

        addChild(qrCodeScanViewController)
        view.addSubview(qrCodeScanViewController.view)

        if FeatureFlags.biometricLinkedDeviceFlow {
            qrCodeScanViewController.view.autoPinEdgesToSuperviewEdges()
            qrCodeScanViewController.didMove(toParent: self)
        } else {
            view.backgroundColor = Theme.backgroundColor

            qrCodeScanViewController.view.autoPinWidthToSuperview()
            qrCodeScanViewController.view.autoPin(toTopLayoutGuideOf: self, withInset: 0)
            qrCodeScanViewController.view.autoPinToSquareAspectRatio()

            let bottomView = UIView()
            bottomView.preservesSuperviewLayoutMargins = true
            view.addSubview(bottomView)
            bottomView.autoPinEdge(.top, to: .bottom, of: qrCodeScanViewController.view)
            bottomView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)

            let heroImage = UIImage(imageLiteralResourceName: "ic_devices_ios")
            let imageView = UIImageView(image: heroImage)
            imageView.autoSetDimensions(to: heroImage.size)

            let bottomStack = UIStackView(arrangedSubviews: [ imageView, scanningInstructionsLabel ])
            bottomStack.axis = .vertical
            bottomStack.alignment = .center
            bottomStack.spacing = 8
            bottomView.addSubview(bottomStack)
            bottomStack.autoPinWidthToSuperviewMargins()
            bottomStack.autoPinHeightToSuperviewMargins(relation: .lessThanOrEqual)
            bottomStack.autoVCenterInSuperview()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !UIDevice.current.isIPad {
            UIDevice.current.ows_setOrientation(.portrait)
        }

        if !hasShownEducationSheet, FeatureFlags.biometricLinkedDeviceFlow {
            let animationName = if traitCollection.userInterfaceStyle == .dark {
                "linking-device-dark"
            } else {
                "linking-device-light"
            }

            let sheet = HeroSheetViewController(
                heroAnimationName: animationName,
                heroAnimationHeight: 192,
                title: OWSLocalizedString(
                    "LINK_DEVICE_SCANNING_INSTRUCTIONS_SHEET_TITLE",
                    comment: "Title for QR Scanning screen instructions sheet"
                ),
                body: OWSLocalizedString(
                    "LINK_DEVICE_SCANNING_INSTRUCTIONS_SHEET_BODY",
                    comment: "Title for QR Scanning screen instructions sheet"
                ),
                buttonTitle: CommonStrings.okayButton
            )

            present(sheet, animated: true)
            hasShownEducationSheet = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        UIDevice.current.isIPad ? .all : .portrait
    }

    override func themeDidChange() {
        super.themeDidChange()

        if !FeatureFlags.biometricLinkedDeviceFlow {
            view.backgroundColor = Theme.backgroundColor
            scanningInstructionsLabel.textColor = Theme.secondaryTextAndIconColor
        }
    }

    // MARK: -

    func confirmProvisioningWithUrl(_ deviceProvisioningUrl: DeviceProvisioningURL) {
        let title = NSLocalizedString(
            "LINK_DEVICE_PERMISSION_ALERT_TITLE",
            comment: "confirm the users intent to link a new device"
        )
        let linkingDescription = NSLocalizedString(
            "LINK_DEVICE_PERMISSION_ALERT_BODY",
            comment: "confirm the users intent to link a new device"
        )

        let actionSheet = ActionSheetController(title: title, message: linkingDescription)
        actionSheet.addAction(ActionSheetAction(
            title: CommonStrings.cancelButton,
            style: .cancel,
            handler: { _ in
                DispatchQueue.main.async {
                    self.popToLinkedDeviceList()
                }
            }
        ))
        actionSheet.addAction(ActionSheetAction(
            title: NSLocalizedString("CONFIRM_LINK_NEW_DEVICE_ACTION", comment: "Button text"),
            style: .default,
            handler: { _ in
                self.provisionWithUrl(deviceProvisioningUrl)
            }
        ))
        presentActionSheet(actionSheet)
    }

    private func provisionWithUrl(_ deviceProvisioningUrl: DeviceProvisioningURL) {
        SSKEnvironment.shared.databaseStorageRef.write { transaction in
            // Optimistically set this flag.
            DependenciesBridge.shared.deviceManager.setMightHaveUnknownLinkedDevice(
                true,
                transaction: transaction.asV2Write
            )
        }

        var localIdentifiers: LocalIdentifiers?
        var aciIdentityKeyPair: ECKeyPair?
        var pniIdentityKeyPair: ECKeyPair?
        var areReadReceiptsEnabled: Bool = true
        var masterKey: Data?
        var isLinkAndSyncEnabled = false
        let mediaRootBackupKey = SSKEnvironment.shared.databaseStorageRef.write { tx in
            localIdentifiers = DependenciesBridge.shared.tsAccountManager.localIdentifiers(tx: tx.asV2Read)
            let identityManager = DependenciesBridge.shared.identityManager
            aciIdentityKeyPair = identityManager.identityKeyPair(for: .aci, tx: tx.asV2Read)
            pniIdentityKeyPair = identityManager.identityKeyPair(for: .pni, tx: tx.asV2Read)
            areReadReceiptsEnabled = OWSReceiptManager.areReadReceiptsEnabled(transaction: tx)
            masterKey = DependenciesBridge.shared.svr.masterKeyDataForKeysSyncMessage(tx: tx.asV2Read)
            isLinkAndSyncEnabled = DependenciesBridge.shared.linkAndSyncManager.isLinkAndSyncEnabledOnPrimary(tx: tx.asV2Read)
            let mrbk = DependenciesBridge.shared.mrbkStore.getOrGenerateMediaRootBackupKey(tx: tx.asV2Write)
            return mrbk
        }

        let ephemeralBackupKey: EphemeralBackupKey?
        if
            isLinkAndSyncEnabled,
            deviceProvisioningUrl.capabilities.contains(where: { $0 == .linknsync })
        {
            ephemeralBackupKey = DependenciesBridge.shared.linkAndSyncManager.generateEphemeralBackupKey()
        } else {
            ephemeralBackupKey = nil
        }

        let myProfileKeyData = SSKEnvironment.shared.profileManagerRef.localProfileKey.keyData

        guard let myAci = localIdentifiers?.aci, let myPhoneNumber = localIdentifiers?.phoneNumber else {
            owsFail("Can't provision without an aci & phone number.")
        }
        guard let aciIdentityKeyPair else {
            owsFail("Can't provision without an aci identity.")
        }
        guard let myPni = localIdentifiers?.pni else {
            owsFail("Can't provision without a pni.")
        }
        guard let pniIdentityKeyPair else {
            owsFail("Can't provision without an pni identity.")
        }
        guard let masterKey else {
            // This should be impossible; the only times you don't have
            // a master key are during registration, and on a linked device.
            owsFail("Can't provision without a master key.")
        }

        let deviceProvisioner = OWSDeviceProvisioner(
            myAciIdentityKeyPair: aciIdentityKeyPair.identityKeyPair,
            myPniIdentityKeyPair: pniIdentityKeyPair.identityKeyPair,
            theirPublicKey: deviceProvisioningUrl.publicKey,
            theirEphemeralDeviceId: deviceProvisioningUrl.ephemeralDeviceId,
            myAci: myAci,
            myPhoneNumber: myPhoneNumber,
            myPni: myPni,
            profileKey: myProfileKeyData,
            masterKey: masterKey,
            mrbk: mediaRootBackupKey,
            ephemeralBackupKey: ephemeralBackupKey,
            readReceiptsEnabled: areReadReceiptsEnabled,
            provisioningService: DeviceProvisioningServiceImpl(
                networkManager: SSKEnvironment.shared.networkManagerRef,
                schedulers: DependenciesBridge.shared.schedulers
            ),
            schedulers: DependenciesBridge.shared.schedulers
        )

        deviceProvisioner.provision().then(on: SyncScheduler()) { tokenId in
            Logger.info("Successfully provisioned device.")
            if isLinkAndSyncEnabled, let ephemeralBackupKey {
                return Promise.wrapAsync {
                    try await DependenciesBridge.shared.linkAndSyncManager.waitForLinkingAndUploadBackup(
                        ephemeralBackupKey: ephemeralBackupKey,
                        tokenId: tokenId
                    )
                }
            } else {
                return .value(())
            }
        }.map(on: DispatchQueue.main) {
            self.delegate?.expectMoreDevices()
            self.popToLinkedDeviceList()
        }.catch(on: DispatchQueue.main) { error in
            Logger.error("Failed to provision device with error: \(error)")
            self.presentActionSheet(self.retryActionSheetController(error: error, retryBlock: { [weak self] in
                self?.provisionWithUrl(deviceProvisioningUrl)
            }))
        }
    }

    private func retryActionSheetController(error: Error, retryBlock: @escaping () -> Void) -> ActionSheetController {
        switch error {
        case let error as DeviceLimitExceededError:
            let actionSheet = ActionSheetController(
                title: error.errorDescription,
                message: error.recoverySuggestion
            )
            actionSheet.addAction(ActionSheetAction(
                title: CommonStrings.okButton,
                handler: { [weak self] _ in
                    self?.popToLinkedDeviceList()
                }
            ))
            return actionSheet

        default:
            let actionSheet = ActionSheetController(
                title: OWSLocalizedString("LINKING_DEVICE_FAILED_TITLE", comment: "Alert Title"),
                message: error.userErrorDescription
            )
            actionSheet.addAction(ActionSheetAction(
                title: CommonStrings.retryButton,
                style: .default,
                handler: { action in retryBlock() }
            ))
            actionSheet.addAction(ActionSheetAction(
                title: CommonStrings.cancelButton,
                style: .cancel,
                handler: { [weak self] action in
                    DispatchQueue.main.async { self?.dismiss(animated: true) }
                }
            ))
            return actionSheet
        }
    }

    private func popToLinkedDeviceList() {
        navigationController?.popViewController(animated: true, completion: {
            UIViewController.attemptRotationToDeviceOrientation()
        })
    }

    #if TESTABLE_BUILD
    @objc
    private func manuallyEnterLinkURL() {
        let alertController = UIAlertController(
            title: LocalizationNotNeeded("Manually enter linking code."),
            message: LocalizationNotNeeded("Copy the URL represented by the QR code into the field below."),
            preferredStyle: .alert
        )
        alertController.addTextField()
        alertController.addAction(UIAlertAction(
            title: CommonStrings.okayButton,
            style: .default,
            handler: { _ in
                guard let qrCodeString = alertController.textFields?.first?.text else { return }
                self.qrCodeScanViewScanned(
                    qrCodeData: nil,
                    qrCodeString: qrCodeString
                )
            }
        ))
        alertController.addAction(UIAlertAction(
            title: CommonStrings.cancelButton,
            style: .cancel
        ))
        present(alertController, animated: true)
    }
    #endif
}

extension LinkDeviceViewController: QRCodeScanOrPickDelegate {

    @discardableResult
    func qrCodeScanViewScanned(
        qrCodeData: Data?,
        qrCodeString: String?
    ) -> QRCodeScanOutcome {
        AssertIsOnMainThread()

        guard let qrCodeString else {
            // Only accept QR codes with a valid string payload.
            return .continueScanning
        }

        guard let url = DeviceProvisioningURL(urlString: qrCodeString) else {
            Logger.error("Unable to parse provisioning params from QRCode: \(qrCodeString)")

            let title = NSLocalizedString("LINK_DEVICE_INVALID_CODE_TITLE", comment: "report an invalid linking code")
            let body = NSLocalizedString("LINK_DEVICE_INVALID_CODE_BODY", comment: "report an invalid linking code")

            let actionSheet = ActionSheetController(title: title, message: body)
            actionSheet.addAction(ActionSheetAction(
                title: CommonStrings.cancelButton,
                style: .cancel,
                handler: { _ in
                    DispatchQueue.main.async {
                        self.popToLinkedDeviceList()
                    }
                }
            ))
            actionSheet.addAction(ActionSheetAction(
                title: NSLocalizedString("LINK_DEVICE_RESTART", comment: "attempt another linking"),
                style: .default,
                handler: { _ in
                    self.qrCodeScanViewController.tryToStartScanning()
                }
            ))
            presentActionSheet(actionSheet)

            return .stopScanning
        }

        confirmProvisioningWithUrl(url)

        return .stopScanning
    }

    func qrCodeScanViewDismiss(_ qrCodeScanViewController: SignalUI.QRCodeScanViewController) {
        AssertIsOnMainThread()
        popToLinkedDeviceList()
    }
}
