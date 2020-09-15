//
//  MediaPlayerViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/14/20.
//

import UIKit
import PDFKit
import AVKit

class MediaPlayerViewController: UIViewController {

    var content: Content?
    var pdfView: PDFView?
    var avPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let content = content else { return }
        guard let url = content.url else { return }

        navigationController?.setNavigationBarHidden(false, animated: false)
        title = content.name

        switch content.format {
        case .pdf:
            pdfView = PDFView(frame: view.safeAreaLayoutGuide.layoutFrame)
            guard let pdfView = pdfView else { return }
            guard let document = PDFDocument(url: url) else { return }
            pdfView.document = document
            pdfView.displayDirection = .vertical
            pdfView.autoScales = true
            pdfView.displayMode = .singlePageContinuous
            if let lastLocation = getLastLocation(),
                let page = document.page(at: lastLocation) {
                pdfView.go(to: PDFDestination(page: page, at: CGPoint(x: 0, y: view.safeAreaLayoutGuide.layoutFrame.size.height)))
            }
            view.addSubview(pdfView)
        case .mp3, .mp4:
            avPlayer = AVPlayer(url: url)
            if let lastLocation = getLastLocation() {
                avPlayer?.seek(to: CMTimeMake(value: Int64(lastLocation), timescale: 1))
            }
            let avPlayerViewController = AVPlayerViewController()
            avPlayerViewController.player = avPlayer
            self.addChild(avPlayerViewController)
            self.view.addSubview(avPlayerViewController.view)
            avPlayerViewController.view.translatesAutoresizingMaskIntoConstraints = false
            avPlayerViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            avPlayerViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            avPlayerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            avPlayerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            avPlayerViewController.didMove(toParent: self)
            avPlayer?.play()
        default:
            break
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        guard let content = content else { return }

        switch content.format {
        case .pdf:
            if let currentPage = pdfView?.currentPage,
                let pageNumber = pdfView?.document?.index(for: currentPage) {
                setLastLocation(pageNumber)
            }
        case .mp3, .mp4:
            if let currentTime = avPlayer?.currentTime() {
                setLastLocation(Int(currentTime.value) / Int(currentTime.timescale))
            }
        default:
            break
        }
    }

    func getLastLocation() -> Int? {
        guard let content = content else { return nil }
        // TODO: make API call
        return UserDefaults.standard.integer(forKey: "\(content.id)-\(Globals.LastLocationUserDefaultsKey)")
    }

    func setLastLocation(_ value: Int) {
        guard let content = content else { return }
        // TODO: make API call
        UserDefaults.standard.set(value, forKey: "\(content.id)-\(Globals.LastLocationUserDefaultsKey)")
    }
}
