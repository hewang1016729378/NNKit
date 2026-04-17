//
//  UIImageExtension.swift

import UIKit
import YYText

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    /// 裁剪圆形图片
    var circle: UIImage {
        // 取最短边长
        let shotest = min(size.width, size.height)
        // 输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        // 开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        // 添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        // 绘制图片
        draw(in: CGRect(x: (shotest - size.width) / 2,
                        y: (shotest - size.height) / 2,
                        width: size.width,
                        height: size.height))

        // 获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }

    class func getImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    // 保存图片至沙盒
    class func saveImage(currentImage: UIImage, persent: CGFloat, imageName: String) {
        if let imageData = currentImage.jpegData(compressionQuality: persent) as NSData? {
            let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
            imageData.write(toFile: fullPath, atomically: true)
            print("fullPath=\(fullPath)")
        }
    }

    class func saveImage(currentImage: UIImage, newSize: CGSize, imageName: String) {
        // 压缩图片尺寸
        UIGraphicsBeginImageContext(newSize)
        currentImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))

        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            if let imageData = newImage.jpegData(compressionQuality: 1) as NSData? {
                let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
                imageData.write(toFile: fullPath, atomically: true)
            }
        }
    }

    class func getImage() -> UIImage? {
        let fullPath = NSHomeDirectory().appending("/Documents/").appending("ic_mine.png")
        if let savedImage = UIImage(contentsOfFile: fullPath) {
//            if let image = savedImage.roundImage( size:CGSize(width: 30, height: 30),lineColor: "#21B9C9".color()) {
//                return image
//            }
            if let image = savedImage.avatarImage(size: CGSize(width: 30, height: 30), lineColor: "#21B9C9".color()) {
                return image
            }
        }
        return nil
    }

    func avatarImage(size: CGSize, backColor: UIColor? = UIColor.white, lineColor: UIColor?) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: size)
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        backColor?.setFill()
        UIRectFill(rect)

        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        lineColor?.setStroke()
        path.lineWidth = 1
        path.stroke()

        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func roundImage(byRoundingCorners: UIRectCorner = .allCorners, size: CGSize, lineColor: UIColor?) -> UIImage? {
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        let bezierPath = UIBezierPath(roundedRect: imageRect, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: size.width / 2, height: size.height / 2))
        bezierPath.addClip()
        lineColor?.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        draw(in: imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    static func stretchableImageWithImgae(image: String) -> UIImage? {
        if let nomal = image.image {
            let w = nomal.size.width * 0.5
            let h = nomal.size.height * 0.5
            return nomal.stretchableImage(withLeftCapWidth: Int(w), topCapHeight: Int(h))
        }
        return nil
    }
    
    func alpha(_ value: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return nil }
        
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ctx.scaleBy(x: 1, y: -1)
        ctx.translateBy(x: 0, y: -area.size.height)
        ctx.setBlendMode(.multiply)
        ctx.setAlpha(value)
        ctx.draw(cgImage, in: area)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    /// 将图片作为NSTextAttachment加入到字符串中
    func attribute(bounds: CGRect, attbuteStr: NSMutableAttributedString, label: YYLabel) -> NSMutableAttributedString {
        let str = attbuteStr
        if let font = label.font {
    //        let paddingTop = (font.lineHeight - bounds.height) / 2.0
            let imageStr = NSAttributedString.yy_attachmentString(withContent: self, contentMode: .scaleAspectFit, attachmentSize: bounds.size, alignTo: font, alignment: .center)
            str.append(imageStr)
    //            str.setAttachmentsAlignment(.justified)
            return str
        }
        return attbuteStr
    }
    /// 获网络图片的宽高比
    /// - Parameter urlString:
    /// - Returns:
    static func getImageRatio(from urlString: String, complete: ((_ aspectRatio: CGFloat?) -> Void)?) {
        GCDUtils.async(.global(), block: {
            guard let imageUrl = URL(string: urlString),
                  let data = try? Data(contentsOf: imageUrl) else { return }

            if let image = UIImage(data: data) {
                print("Width: \(image.size.width)") // 输出图像的宽度
                print("Height: \(image.size.height)") // 输出图像的高度

                let aspectRatio = image.size.width / image.size.height
                print("Aspect Ratio: \(aspectRatio)") // 输出图像的宽高比
                complete?(aspectRatio)
            }
        })
    }
}
