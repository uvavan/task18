//
//  ViewController.swift
//  task18
//
//  Created by Admin on 28.11.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var ibImageViewFirst: UIImageView!
    @IBOutlet private weak var ibImageViewSecond: UIImageView!
    @IBOutlet private weak var ibImageViewThird: UIImageView!
    @IBOutlet private weak var ibImageLoadActivityFirst: UIActivityIndicatorView!
    @IBOutlet private weak var ibImageLoadActivitySecond: UIActivityIndicatorView!
    @IBOutlet private weak var ibImageLoadActivityThird: UIActivityIndicatorView!
    @IBOutlet private weak var ibStackViewImage: UIStackView!
    private var imageIndex = 0
    private let FirstImageUrl = ["http://sf.co.ua/16/09/wallpaper-42d88.jpg", "http://sf.co.ua/16/06/wallpaper-1c5bd.jpg", "http://sf.co.ua/16/08/wallpaper-16002.jpg", "http://sf.co.ua/16/06/wallpaper-4f28.jpg"]
    private let SecondImageUrl = ["https://www.nasa.gov/sites/default/files/thumbnails/image/15-066.png", "http://gde-fon.com/download/space_dark_universe/36664/1920x1200", "http://co13.nevseoboi.com.ua/17/16427/1384034809-3097609-nevseoboi.com.ua.jpg", "http://co13.nevseoboi.com.ua/17/16427/1384034810-3097589-nevseoboi.com.ua.jpg"]
    private let ThirdImageUrl = ["http://i.artfile.ru/3500x2015_861945_[www.ArtFile.ru].jpg", "http://www.rabstol.net/uploads/gallery/main/183/rabstol_net_orchids_05.jpg", "https://wallpaperscraft.ru/image/orhideya_cvetok_vetka_ekzotika_55983_602x339.jpg", "http://peterbald-cat.ru/oboi/1/rozy_orhidei_cvety_buket_chernyy_fon_1920x1180.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshImage(by: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stackViewOrientation()
    }
    
    private func stackViewOrientation() {
        if self.preferredInterfaceOrientationForPresentation == .portrait ||
            self.preferredInterfaceOrientationForPresentation == .portraitUpsideDown {
            ibStackViewImage.axis = .vertical
        } else {
            ibStackViewImage.axis = .horizontal
        }
    }
    
    @IBAction private func ButtonRefreshPress(_ sender: Any) {
        imageIndex = (imageIndex + 1) % FirstImageUrl.count
        refreshImage(by: imageIndex)
    }
    
    private func refreshImage(by index: Int) {
        loadViewImage(by: index, loadUrl: FirstImageUrl, viewImage: ibImageViewFirst, loadActivity: ibImageLoadActivityFirst)
        loadViewImage(by: index, loadUrl: SecondImageUrl, viewImage: ibImageViewSecond, loadActivity: ibImageLoadActivitySecond)
        loadViewImage(by: index, loadUrl: ThirdImageUrl, viewImage: ibImageViewThird, loadActivity: ibImageLoadActivityThird)
    }
    
    private func stopAnimatingIndicator(of sender: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            sender.stopAnimating()
            sender.isHidden = true
        }
    }
    
    private func loadViewImage(by index: Int, loadUrl: [String], viewImage: UIImageView, loadActivity: UIActivityIndicatorView) {
        guard index >= 0, index < loadUrl.count else { return }
        let imageStringUrl = loadUrl[index]
        guard let url = URL(string: imageStringUrl) else { return }
        loadActivity.isHidden = false
        loadActivity.startAnimating()
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: url) else {
                self?.stopAnimatingIndicator(of: loadActivity)
                return
            }
            let image = UIImage (data: imageData)
            DispatchQueue.main.async {
                viewImage.image = image
                self?.stopAnimatingIndicator(of: loadActivity)
            }
        }
    }
    
}

