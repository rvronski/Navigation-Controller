//
//  MusicViewController.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 10.12.2022.
//


import UIKit
import AVFoundation

class MusicViewController: UIViewController {
    var counter = 0
    let songs = ["Queen","Just The Two Of Us","09 We Like Songs","Chet Faker  - No Diggity Live Sessions","All I Do (Todd Terje Edit)"]
    let albums = [UIImage(named: "IMG_8282.JPG"), UIImage(named: "IMG_8283.JPG"), UIImage(named: "IMG_8284.JPG"), UIImage(named: "IMG_8285.JPG"),UIImage(named: "IMG_8286.JPG")]
    
    private lazy var songNameLabel: UILabel = {
        let songNameLabel = UILabel()
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return songNameLabel
    }()
    
    private lazy var songTimeLabel: UILabel = {
        let songTimeLabel = UILabel()
        songTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return songTimeLabel
    }()
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var musicSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(touchSlider), for: .valueChanged)
        return slider
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton()
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        return playButton
    }()
    
    private lazy var stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        return stopButton
    }()
    
    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.isHidden = true
        pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        return pauseButton
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        return nextButton
    }()
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backSong), for: .touchUpInside)
        return backButton
    }()
    var player = AVAudioPlayer()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        music()
        musicSlider.value = 0.0
    }
        
    deinit {
        timer.invalidate()
    }
    private func music() {
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "\(songs[counter])", ofType: "mp3")!))
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
        self.albumImageView.image = albums.randomElement()!!
    }
    
    @objc func nextSong() {
        if (self.counter + 1) == songs.count {
            self.counter = -1
        }
        self.counter += 1
        music()
        play()
        player.currentTime = 0
        
    }
    
    
    
    @objc func backSong() {
        if counter > 0 {
            self.counter -= 1
            music()
            play()
            player.currentTime = 0
        } else {
            stop()
            play()
            return
        }
    }
    
    @objc func pause() {
        player.pause()
        self.playButton.isHidden.toggle()
        self.pauseButton.isHidden.toggle()
    }
    
    @objc func play() {
        
        
        musicSlider.maximumValue = Float(player.duration)
        songNameLabel.text = songs[counter]
        if player.isPlaying {
            self.playButton.isHidden = true
            self.pauseButton.isHidden = false
        } else {
            player.play()
            self.playButton.isHidden = true
            self.pauseButton.isHidden = false
            timer = Timer.scheduledTimer(
                withTimeInterval: 0.05,
                repeats: true
            ) { [weak self] timer in
                self?.updateMusicSlider()
            }
            timer.fire()
        }
    }
    @objc func stop() {
        if player.isPlaying {
            player.stop()
            player.currentTime = 0
            self.playButton.isHidden.toggle()
            self.pauseButton.isHidden.toggle()
//            timer.invalidate()
        }
        else {
            player.currentTime = 0
        }
    }
    
    @objc func touchSlider() {
        player.currentTime = TimeInterval(musicSlider.value)
    }
    
    @objc func updateMusicSlider() {
        musicSlider.value = Float(player.currentTime)
        var songTime = Int(player.duration) - Int(player.currentTime)
        let minutes = String(songTime / 60)
        let seconds = String(songTime % 60)
        self.songTimeLabel.text = minutes + ":" + seconds
        
    }
    private func setup() {
        self.view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.stopButton)
        self.view.addSubview(self.pauseButton)
        self.view.addSubview(self.musicSlider)
        self.view.addSubview(self.nextButton)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.songNameLabel)
        self.view.addSubview(self.albumImageView)
        self.view.addSubview(self.songTimeLabel)
        
        NSLayoutConstraint.activate([
            self.playButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            self.playButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.playButton.widthAnchor.constraint(equalToConstant: 50),
            self.playButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.pauseButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            self.pauseButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50),
            self.pauseButton.widthAnchor.constraint(equalToConstant: 50),
            self.pauseButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.stopButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            self.stopButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            self.stopButton.widthAnchor.constraint(equalToConstant: 50),
            self.stopButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            self.musicSlider.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 20),
            self.musicSlider.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -20),
            self.musicSlider.bottomAnchor.constraint(equalTo: self.playButton.topAnchor, constant: -20),
            
            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            self.nextButton.rightAnchor.constraint(equalTo: self.stopButton.leftAnchor, constant: -50),
            self.nextButton.widthAnchor.constraint(equalToConstant: 50),
            self.nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.backButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            self.backButton.leftAnchor.constraint(equalTo: self.playButton.rightAnchor, constant: 50),
            self.backButton.widthAnchor.constraint(equalToConstant: 50),
            self.backButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.songNameLabel.bottomAnchor.constraint(equalTo: self.musicSlider.topAnchor, constant: -20),
            self.songNameLabel.leftAnchor.constraint(equalTo: self.musicSlider.leftAnchor),
            self.songNameLabel.rightAnchor.constraint(equalTo: self.musicSlider.rightAnchor),
            self.songNameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.albumImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 50),
            self.albumImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.albumImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            self.albumImageView.bottomAnchor.constraint(equalTo: self.songNameLabel.topAnchor, constant: -20),
            
            self.songTimeLabel.heightAnchor.constraint(equalToConstant: 15),
            self.songTimeLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -20),
            self.songTimeLabel.topAnchor.constraint(equalTo: self.musicSlider.bottomAnchor, constant: 5),
            self.songTimeLabel.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}


