
import CoreImage
var redKernel_str = 
    """
        kernel vec4 thresholdFilter(__sample textureColor) {

            if (textureColor.r > 0.6 && textureColor.g < 0.1 && textureColor.b < 0.4) {
                textureColor.rgb = vec3(1.0, 1.0, 1.0);
            } else {
                textureColor.rgb = vec3(0.0 , 0.0, 0.0);
            }

            return textureColor;
        }
        """

var greenKernel_str = 
    """
        kernel vec4 thresholdFilter(__sample textureColor) {

            if (textureColor.r < 0.08 && textureColor.g > 0.1 && textureColor.b < 2) {
                textureColor.rgb = vec3(1.0, 1.0, 1.0);
            } else {
                textureColor.rgb = vec3(0.0 , 0.0, 0.0);
            }

            return textureColor;
        }
        """

var yellowKernel_str = 
    """
        kernel vec4 thresholdFilter(__sample textureColor) {

            if (textureColor.r > 0.7 && textureColor.g > 0.6 && textureColor.b < 0.35) {
                textureColor.rgb = vec3(1.0, 1.0, 1.0);
            } else {
                textureColor.rgb = vec3(0.0 , 0.0, 0.0);
            }

            return textureColor;
        }
        """


public class CustomMasks{
    public var redKernel: CIColorKernel;
    public var greenKernel: CIColorKernel;
    public var yellowKernel: CIColorKernel;
    public init() {
        self.redKernel = CIColorKernel(source: redKernel_str)!
        self.greenKernel = CIColorKernel(source: greenKernel_str)!
        self.yellowKernel = CIColorKernel(source: yellowKernel_str)!
    }
    
    public func red(ciInputImage: CIImage)->CIImage{
        let ciImageMasked = self.redKernel.apply(
            extent: ciInputImage.extent,
            arguments: [ciInputImage])!
        return ciImageMasked
    }
    
    public func yellow(ciInputImage: CIImage)->CIImage{
        let ciImageMasked = self.yellowKernel.apply(
            extent: ciInputImage.extent,
            arguments: [ciInputImage])!
        return ciImageMasked
    }
    
    public func green(ciInputImage: CIImage)->CIImage{
        let ciImageMasked = self.greenKernel.apply(
            extent: ciInputImage.extent,
            arguments: [ciInputImage])!
        return ciImageMasked
    }
}
