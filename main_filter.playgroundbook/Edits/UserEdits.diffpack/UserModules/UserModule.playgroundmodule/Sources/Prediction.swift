

import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

extension UIImage {
    var averageColor: [CGFloat]? {
        guard let inputImage = self.ciImage else { return nil }
        
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return [CGFloat(bitmap[0]) / 255, CGFloat(bitmap[1]) / 255, CGFloat(bitmap[2]) / 255, CGFloat(bitmap[3]) / 255]
    }
    
}





public func predict(inputImage:UIImage)->String {
    let filter = CustomFilters()
    
    let rOut = filter.red_mask(inputImage: inputImage)
    let yOut = filter.yellow_mask(inputImage: inputImage)
    let gOut = filter.green_mask(inputImage: inputImage)
    
    
    let resRout = rOut.resizeImage(newWidth: 5)
    let resGout = gOut.resizeImage(newWidth: 5)
    let resYout = yOut.resizeImage(newWidth: 5)
    
    let rRGB = get_color(image: resRout)
    let gRGB = get_color(image: resGout)
    let yRGB = get_color(image: resYout)

    var rygList=["red":rRGB![0], "yellow":yRGB![0], "green":gRGB![0]
    ]
    let maxColor = rygList.max { a, b in a.value < b.value }
    if (maxColor!.value == 0){
        print(maxColor!.value)
        return "Not Sure"
    }
    return maxColor!.key
}
//  let image = UIImage(named: "yellow.jpg")!
//  
//  print(predict(inputImage: image))
//  
//  
//  
