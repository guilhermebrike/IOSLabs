//
//  ViewController.swift
//  NetworkingBasics
//
//  Created by Guilherme Wahlbrink on 2019-05-07.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate, URLSessionTaskDelegate {
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
            // 5. update UI (main thread)
        let myImageData = try! Data(contentsOf: location)
        OperationQueue.main.addOperation {
            self.phoneImageView.image = UIImage(data: myImageData)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print(progress)
    }
    
    let phoneImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(phoneImageView)
        phoneImageView.matchParent()
        
        // 1. create an url object
        guard let url = URL(string: "http://imgur.com/zdwdenZ.png") else { return }
        // 2. create an URLSession object
        //let session = URLSession.shared // singleton object (basic configuration)
        let configuration = URLSessionConfiguration.background(withIdentifier: "ca.ciccc.network")
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue())
        
        
        // other way to make it work
//        // 3. create a task (downloadTask)
//
//        let task = session.downloadTask(with: url) { (location, response, err) in
//
//            // error checking
//            if let err = err {
//                print("Error:", err)
//                return
//            }
//
//            // 5. update UI (main thread)
//            if let location = location {
//                OperationQueue.main.addOperation {
//                    self.phoneImageView.image = try? UIImage(data: Data(contentsOf: location))
//                }
//            }
//        }
        
        let task = session.downloadTask(with: url)
        
        
        //4. resume! ( by default, tassk -> suspend state)
        
        task.resume()
    
    }

}

