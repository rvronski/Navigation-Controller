//
//  VideoView.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 10.12.2022.
//

import UIKit
import WebKit

class VideoView: UIView {
    private lazy var wv: WKWebView = {
        let wv = WKWebView()
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()
    var videoArray = ["3Xv1mJvwXok","pCVXSle3e74","RmHqOSrkZnk","5tpQEsJ0iVg","I4GLs3RXKnM", "3kiPK9hdCK4"]
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: "VideoCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setup()
        DispatchQueue.global().async {
            self.loadYoutube(videoID: "3kiPK9hdCK4") { [weak self] urlText in
                DispatchQueue.main.async {
                    self?.wv.loadHTMLString(urlText, baseURL: nil)
                }
                
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func closeView() {
        self.isHidden = true
        
    }
    
    private func setup() {
        self.addSubview(self.closeButton)
        self.addSubview(self.tableView)
        self.addSubview(self.wv)
        self.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            self.wv.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 35),
            self.wv.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.wv.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.wv.heightAnchor.constraint(equalToConstant: 300),
            
            self.tableView.topAnchor.constraint(equalTo: self.wv.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.closeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            
        ])
        
    }
    
    func loadYoutube(videoID:String, completion: ((String) -> Void)) {
        let toLoadInWebView = "<body style=\"margin:0px;padding:0px;overflow:hidden\">"
        + " <iframe  style=\"overflow: hidden; overflow-x: hidden; overflow-y:hidden; height: 0;" + " max-height: 100%; max-width: 100%; min-height: 100%; min-width: 100%; width: 0;scrolling:no;position:absolute;top:0px;left:0px;right:0px;bottom:0px\" " + "src=\"https://www.youtube.com/embed/\(videoID)\"></iframe>" + "</body>"
        
        completion(toLoadInWebView)
        
    }
    
}



extension VideoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        let viewModel = VideoTableViewCell.ViewModel(name: "Video \(indexPath.row + 1)")
        cell.setup(viewModel: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let select: String = videoArray[indexPath.row]
        DispatchQueue.global().async {
            self.loadYoutube(videoID: select) { [weak self] urlText in
                DispatchQueue.main.async {
                    self?.wv.loadHTMLString(urlText, baseURL: nil)
                }
                
            }
        }
        
    }
    
}
