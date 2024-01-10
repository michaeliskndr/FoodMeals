//
//  File.swift
//  
//
//  Created by Michael Iskandar on 10/01/24.
//

import UIKit

class MealViewerController: UIViewController, UIScrollViewDelegate {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "multiply"), for: .normal)
        }
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        return button
    }()

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black.withAlphaComponent(0.5)
        scrollView.delegate = self
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1.0
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.width.height.centerX.centerY.equalToSuperview()
        }
        
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(24)
        }
        
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
            doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @objc func didTapDismiss(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
