//
//  UIImage+UrlImage.swift
//  collectionViewInsideTableView
//
//  Created by Kushal Choudhary on 03/05/21.
//

import Foundation
import UIKit
extension UIImageView {
  
    func imageFromUrl(urlString: String, handler : ((Bool)-> Void)?) -> URLSessionDataTask? {
        self.image = UIImage()
        if let url = URL(string: urlString) {
            //checking in the file manager
            if let cachedImage = ImageViewerDataSource.shared.getImage(id: urlString ) {
                self.image = cachedImage.imageWith(newSize: CGSize(width: 200, height: 200))
                handler?(true)
                return nil
            }
            //if not in file manager then go for downloading the image from url
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
                if let imageData = data {
                    if let downloadedimage = UIImage(data: imageData){
                        DispatchQueue.main.async {
                            let image = downloadedimage.imageWith(newSize: CGSize(width: 200, height: 200))
                            self.image = image
                            handler?(true)
                        }
                        ImageViewerDataSource.shared.saveImageDocumentDirectory(id: urlString, image: downloadedimage)
                    }
                }else{
                   handler?(false)
                }
            }
            task.resume()
            return task
        }
        return nil
    }
}

class ImageViewerDataSource {
    static var shared = ImageViewerDataSource()
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("SnippetDATA")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
    func getImage(id: String)-> UIImage?{
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(id.toBase64())
        if fileManager.fileExists(atPath: imagePAth){
            return UIImage(contentsOfFile: imagePAth)
            // self.imageView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("Image not present in Disk, Downloading from Server")
            return nil
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func saveImageDocumentDirectory(id: String, image: UIImage){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(id.toBase64())
        //print(paths)
        let imageData = image.jpegData(compressionQuality: 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
}

