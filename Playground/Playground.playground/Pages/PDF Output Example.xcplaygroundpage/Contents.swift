import Cocoa
import Quartz

let inUrl: URL = URL(fileURLWithPath: "/Users/rgordon/Desktop/in.pdf")
let outUrl: CFURL = URL(fileURLWithPath: "/Users/rgordon/Desktop/testout.pdf") as CFURL

let doc: PDFDocument = PDFDocument(url: inUrl)!
let page: PDFPage = doc.page(at: 0)!
var mediaBox: CGRect = page.bounds(for: .mediaBox)

let gc = CGContext(outUrl, mediaBox: &mediaBox, nil)!
let nsgc = NSGraphicsContext(cgContext: gc, flipped: false)
NSGraphicsContext.current = nsgc
gc.beginPDFPage(nil); do {
    page.draw(with: .mediaBox, to: gc)
    
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    
    let richText = NSAttributedString(string: "Hello, world!", attributes: [
        NSAttributedString.Key.font: NSFont.systemFont(ofSize: 64),
        NSAttributedString.Key.foregroundColor: NSColor.red,
        NSAttributedString.Key.paragraphStyle: style
        ])
    
    let richTextBounds = richText.size()
    let point = CGPoint(x: mediaBox.midX - richTextBounds.width / 2, y: mediaBox.midY - richTextBounds.height / 2)
    gc.saveGState(); do {
        gc.translateBy(x: point.x, y: point.y)
        gc.rotate(by: .pi / 5)
        richText.draw(at: .zero)
    }; gc.restoreGState()
    
}; gc.endPDFPage()
NSGraphicsContext.current = nil
gc.closePDF()

//import Cocoa
//
//let fileName = "test.pdf"
//
//func getPath() -> NSURL? {
//    let fileManager = NSFileManager.defaultManager()
//    do {
//        let dir = try fileManager.URLForDirectory(
//            NSSearchPathDirectory.DocumentDirectory,
//            inDomain: NSSearchPathDomainMask.UserDomainMask,
//            appropriateForURL: nil,
//            create: false
//        )
//        return dir.URLByAppendingPathComponent(fileName)
//    } catch {
//        return nil
//    }
//}
//
//
//let context = CGContext(getPath()!, mediaBox: nil, nil)!
//context.beginPDFPage(nil)
//
//let graphicsContext = NSGraphicsContext(cgContext: context, flipped:true)
//NSGraphicsContext.saveGraphicsState()
//NSGraphicsContext.setCurrentContext(graphicsContext)
//
//let path = NSBezierPath(rect: NSRect(x: 0, y: 0, width: 100, height: 100))
//NSColor.greenColor().set()
//path.fill()
//
//CGPDFContextEndPage(context)
//CGPDFContextClose(context)
