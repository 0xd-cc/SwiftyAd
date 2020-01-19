//
//  ContentView.swift
//  SplashAd.Swift
//
//  Created by 0xd on 2020/1/7.
//

class ContentView: UIView {
    private lazy var imageView: SplashImageView = {
        return SplashImageView()
    }()
    
    lazy var skipButton: UIButton = {
        return SplashAd.skipButtonGenerator()
    }()
    
    private var eventCompleteHanlder: (Event) -> Void
    
    init(resource: Resourse, eventCompleteHanlder: @escaping ((Event) -> Void)) {
        self.eventCompleteHanlder = eventCompleteHanlder
        super.init(frame: .zero)
        setupSubviews()
        let postfix = resource.fileName.pathExtension
        switch postfix {
        case ".png", ".jpg", ".jpeg", ".gif":
//            let file = Bundle.main.path(forResource: resource.fileName.components(separatedBy: postfix)[0], ofType: postfix.components(separatedBy: ".")[1])
//            imageView.gifImage = SplashImage(contentsOfFile: file!)
            imageView.showLocalImageOrGif(name: resource.fileName.components(separatedBy: postfix)[0], postfix: postfix)
//            imageView.gifImage = SplashImage(named: "Splash3", postfix: ".gif")
//            imageView.isHighlighted = true
        default:
            print("11")
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
//        imageView.backgroundColor = .red
        
        addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skipButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            skipButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            skipButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        skipButton.isHidden = SplashAd.configuration.isSkipButtonHidden
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
    }
    
    @objc private func skip() {
        eventCompleteHanlder(.skip)
    }
}

extension ContentView {
    enum Event {
        case skip
        case click(ad: ResourseType)
    }
}

fileprivate extension String {
    /// 从url中获取后缀 例：.png
    var pathExtension: String {
        guard let url = URL(string: self) else { return "" }
        return url.pathExtension.isEmpty ? "" : ".\(url.pathExtension)"
    }
}
