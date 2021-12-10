

import CoreImage
import CoreImage.CIFilterBuiltins
import UIKit

public class CustomFilters{
    public var masks: CustomMasks
    public init(){
        self.masks = CustomMasks()
    }
    func red_mask(inputImage: UIImage)->UIImage {
        guard let ciInputImage = CIImage(image: inputImage) else { return <#default value#> }
        let filtered = self.masks.red(ciInputImage: ciInputImage)
        let filteredImage = UIImage(ciImage: filtered)
        return filteredImage
    }
    
    func green_mask(inputImage: UIImage)->UIImage {
        guard let ciInputImage = CIImage(image: inputImage) else { return <#default value#> }
        let filtered = self.masks.green(ciInputImage: ciInputImage)
        let filteredImage = UIImage(ciImage: filtered)
        return filteredImage
    }
    
    func yellow_mask(inputImage: UIImage)->UIImage {
        guard let ciInputImage = CIImage(image: inputImage) else { return <#default value#> }
        let filtered = self.masks.yellow(ciInputImage: ciInputImage)
        let filteredImage = UIImage(ciImage: filtered)
        return filteredImage
    }
}
