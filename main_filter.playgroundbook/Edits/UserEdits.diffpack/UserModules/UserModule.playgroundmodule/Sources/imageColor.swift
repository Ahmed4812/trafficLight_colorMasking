import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit
import Foundation


public func get_color(image: UIImage) ->[Int]?{
    guard let cgImage = image.cgImage else { return nil} 
    
    var colorSpace = CGColorSpaceCreateDeviceRGB()
    
    var bitmapInfo: UInt32 = CGBitmapInfo.byteOrder32Big.rawValue
    bitmapInfo |= CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue
    
    let width = Int(image.size.width)
    let height = Int(image.size.height)
    var bytesPerRow = width * 4
    
    let imageData = UnsafeMutablePointer<Pixel>.allocate(capacity: width * height)
    
    
    guard let imageContext = CGContext(
        data: imageData,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    ) else { return nil}
    
    imageContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    let pixels = UnsafeMutableBufferPointer<Pixel>(start: imageData, count: width * height)
    
    var totalRed = 0
    var totalGreen = 0
    var totalBlue = 0
    let pixelArea = width * height
    
    for y in 0..<height {
        for x in 0..<width {
            let index = y * width + x
            let pixel = pixels[index]
//              print("pixel red:",pixel.red)
            totalRed += Int(pixel.red)
            
//              print("total red",totalRed)
            totalGreen += Int(pixel.green)
            totalBlue += Int(pixel.blue)
        }
    }
    
    return [totalRed,totalGreen,totalBlue]
}


public struct Pixel {
    public var value: UInt32
    
    public var red: UInt8 {
        get {
            return UInt8(value & 0xFF)
        } set {
            value = UInt32(newValue) | (value & 0xFFFFFF00)
        }
    }
    
    public var green: UInt8 {
        get {
            return UInt8((value >> 8) & 0xFF)
        } set {
            value = (UInt32(newValue) << 8) | (value & 0xFFFF00FF)
        }
    }
    
    public var blue: UInt8 {
        get {
            return UInt8((value >> 16) & 0xFF)
        } set {
            value = (UInt32(newValue) << 16) | (value & 0xFF00FFFF)
        }
    }
    
    public var alpha: UInt8 {
        get {
            return UInt8((value >> 24) & 0xFF)
        } set {
            value = (UInt32(newValue) << 24) | (value & 0x00FFFFFF)
        }
    }
}



extension UIImage {
    public func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    } }
