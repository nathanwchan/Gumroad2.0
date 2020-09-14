//
//  MediaPlayerViewController.swift
//  Gumroad 2.0
//
//  Created by Nathan Chan on 9/14/20.
//

import UIKit
import PDFKit

class MediaPlayerViewController: UIViewController {

    var content: Content?
    var pdfView: PDFView?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let content = content else { return }
        guard let url = content.url else { return }

        navigationController?.setNavigationBarHidden(false, animated: false)
        title = content.name

        pdfView = PDFView(frame: view.safeAreaLayoutGuide.layoutFrame)
        guard let pdfView = pdfView else { return }
        guard let document = PDFDocument(url: url) else { return }
        pdfView.document = document
        pdfView.displayDirection = .vertical
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        let lastLocation = UserDefaults.standard.integer(forKey: "\(content.id)-\(Globals.LastLocationUserDefaultsKey)")
        if let page = document.page(at: lastLocation) {
            pdfView.go(to: PDFDestination(page: page, at: CGPoint(x: 0, y: view.safeAreaLayoutGuide.layoutFrame.size.height)))
        }

        view.addSubview(pdfView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let content = content,
            let currentPage = pdfView?.currentPage,
            let pageNumber = pdfView?.document?.index(for: currentPage) {
            UserDefaults.standard.set(pageNumber, forKey: "\(content.id)-\(Globals.LastLocationUserDefaultsKey)")
        }
    }
}
