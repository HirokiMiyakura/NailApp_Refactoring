@IBDesignable class CustomButton: UIButton {
    
    // 角丸の半径(0で四角形)
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    // 枠
    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
    @IBInspectable var borderWidth: CGFloat = 0.0
    
    override func drawRect(rect: CGRect) {
        // 角丸
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = (cornerRadius > 0)
        
        // 枠線
        self.layer.borderColor = borderColor.CGColor
        self.layer.borderWidth = borderWidth
        
        // 背景
//        self.backgroundColor = UIColor.whiteColor()
        
        super.drawRect(rect)
    }
    
    @IBInspectable var highlightedBackgroundColor :UIColor?
    @IBInspectable var nonHighlightedBackgroundColor :UIColor?
//    override var highlighted :Bool {
//        didSet {
//            if highlighted {
//                self.backgroundColor = highlightedBackgroundColor
//            }
//            else {
//                self.backgroundColor = nonHighlightedBackgroundColor
//            }
//        }
//    }
}