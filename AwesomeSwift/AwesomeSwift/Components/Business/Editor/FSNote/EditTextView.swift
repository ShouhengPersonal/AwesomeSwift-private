//
//  EditTextView.swift
//  FSNotes iOS
//
//  Created by Oleksandr Glushchenko on 1/29/18.
//  Copyright © 2018 Oleksandr Glushchenko. All rights reserved.
//

import UIKit
import MobileCoreServices

class EditTextView: UITextView, UITextViewDelegate {

//    public var editorViewController: EditorViewController?
    public var textStorageProcessor: TextStorageProcessor?
    
    public var isFillAction = false
    public var isAllowedScrollRect: Bool?
    public var typingFont: UIFont?
    public var note: Note? = Note()
    public var lasTouchPoint: CGPoint?
    public var imagesLoaderQueue = OperationQueue.init()
    public var keyboardIsOpened = true
    public var callCounter = 0
    
    private var isHighlighted: Bool = false

    private var undoIcon = UIImage(named: "undo.png")
    private var redoIcon = UIImage(named: "redo.png")

    required init?(coder: NSCoder?) {
        super.init(frame: .zero, textContainer: nil)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentMode = .scaleToFill

        self.isScrollEnabled = false   // causes expanding height

        // Auto Layout
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont(name: "HelveticaNeue", size: 18)

        autocorrectionType = UserDefaultsManagement.editorAutocorrection ? .yes : .no
        spellCheckingType = UserDefaultsManagement.editorSpellChecking ? .yes : .no
        
        self.textContainerInset = UIEdgeInsets(top: 13, left: 10, bottom: 0, right: 10)
        self.keyboardDismissMode = .interactive
        
        self.delegate = self
    }
    
    public func initTextStorage() {
        let processor = TextStorageProcessor()
        processor.editor = self
        
        textStorageProcessor = processor
        textStorage.delegate = processor
    }

    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        let selectionRects = super.selectionRects(for: range)

        let fontHeight = UserDefaultsManagement.noteFont.lineHeight
        let lineSpacing = CGFloat(UserDefaultsManagement.editorLineSpacing)
        let endCharacterIndex = offset(from: beginningOfDocument, to: range.end)
        let endParRange = textStorage.mutableString.paragraphRange(for: NSRange(location: endCharacterIndex, length: 0))

        var lastWideRect: UITextSelectionRect?
        if selectionRects.count > 2 {
            lastWideRect = selectionRects[selectionRects.count - 3]
        }

        var result = [UITextSelectionRect]()
        for selectionRect in selectionRects {
            if selectionRect.rect.width == 0 {
                let customRect = CGRect(x: selectionRect.rect.origin.x, y: selectionRect.rect.origin.y - lineSpacing / 2, width: 0, height: fontHeight + lineSpacing)
                let sel = EditorSelectionRect(originalRect: selectionRect, rect: customRect)
                result.append(sel)
            } else {
                var heightOffset = CGFloat(0)

                if endParRange.upperBound == textStorage.length && lastWideRect == selectionRect {
                    heightOffset += lineSpacing
                }

                let customRect = CGRect(x: selectionRect.rect.origin.x, y: selectionRect.rect.origin.y - lineSpacing / 2, width: selectionRect.rect.width, height: selectionRect.rect.height + heightOffset)

                let selectionRect = EditorSelectionRect(originalRect: selectionRect, rect: customRect)
                result.append(selectionRect)
            }
        }

        return result
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        let characterIndex = offset(from: beginningOfDocument, to: position)

        guard layoutManager.isValidGlyphIndex(characterIndex) else {
            return super.caretRect(for: position)
        }

        let glyphIndex = layoutManager.glyphIndexForCharacter(at: characterIndex)
        let usedLineFragment = layoutManager.lineFragmentUsedRect(forGlyphAt: glyphIndex, effectiveRange: nil)

        guard !usedLineFragment.isEmpty else {
            return super.caretRect(for: position)
        }

        var caretRect = super.caretRect(for: position)
        caretRect.origin.y = usedLineFragment.origin.y + textContainerInset.top
        caretRect.size.height = usedLineFragment.size.height - CGFloat(UserDefaultsManagement.editorLineSpacing) / 2

        return caretRect
    }

    override func scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        guard isAllowedScrollRect == true else { return }

        callCounter += 1

        if keyboardIsOpened {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.8, delay: 0, options: .beginFromCurrentState, animations: {
                    super.scrollRectToVisible(rect, animated: false)
                })
            }

            if callCounter > 2 {
                keyboardIsOpened = false
                callCounter = 0
            }
        } else {
            super.scrollRectToVisible(rect, animated: animated)
        }
    }

    override func cut(_ sender: Any?) {
//        guard let note = self.note else {
//            super.cut(sender)
//            return
//        }

        let attributedString = NSMutableAttributedString(attributedString: self.textStorage.attributedSubstring(from: self.selectedRange)).unLoadCheckboxes()

        let pathKey = NSAttributedString.Key(rawValue: "co.fluder.fsnotes.image.path")
//        if self.selectedRange.length == 1, let path = attributedString.attribute(pathKey, at: 0, effectiveRange: nil) as? String,
//            let imageUrl = note.getImageUrl(imageName: path),
//            let data = try? Data(contentsOf: imageUrl),
//            let image = UIImage(data: data),
//            let jpgData = image.jpegData(compressionQuality: 1) {
//
//            let location = selectedRange.location
//
//            if let textRange = getTextRange() {
//                self.replace(textRange, withText: "")
//            }
//
//            self.layoutManager.invalidateDisplay(forCharacterRange: NSRange(location: location, length: 1))
//            self.selectedRange = NSRange(location: location, length: 0)
//
//            UIPasteboard.general.setData(jpgData, forPasteboardType: "public.jpeg")
//            return
//        }

        if self.textStorage.length >= self.selectedRange.upperBound {
            if let rtfd = try? attributedString.data(
                from: NSMakeRange(0, attributedString.length),
                documentAttributes: [
                    NSAttributedString.DocumentAttributeKey.documentType:
                        NSAttributedString.DocumentType.rtfd
                ]
            ) {
                UIPasteboard.general.setData(rtfd, forPasteboardType: "es.fsnot.attributed.text"
                )

                if let textRange = getTextRange() {
                    self.replace(textRange, withText: "")
                }

                return
            }

            let item = [kUTTypeUTF8PlainText as String : attributedString.string as Any]
            UIPasteboard.general.items = [item]
        }

        super.cut(sender)
    }

    override func paste(_ sender: Any?) {
        guard let note = self.note else {
            super.paste(sender)
            return
        }

//        note.invalidateCache()
//        textStorageProcessor?.shouldForceRescan = true
//
//        for item in UIPasteboard.general.items {
//            if let rtfd = item["es.fsnot.attributed.text"] as? Data {
//                if let attributedString = try? NSAttributedString(data: rtfd, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.rtfd], documentAttributes: nil) {
//
//                    let attributedString = NSMutableAttributedString(attributedString: attributedString)
//                    attributedString.loadCheckboxes()
//                    
//                    let newRange = NSRange(location: selectedRange.location, length: attributedString.length)
//                    attributedString.removeAttribute(.backgroundColor, range: NSRange(0..<attributedString.length))
//
//                    if let selTextRange = selectedTextRange, let undoManager = undoManager {
//                        undoManager.beginUndoGrouping()
//                        self.replace(selTextRange, withText: attributedString.string)
//                        self.textStorage.replaceCharacters(in: newRange, with: attributedString)
//                        undoManager.endUndoGrouping()
//                    }
//
//                    self.layoutManager.invalidateDisplay(forCharacterRange: NSRange(location: 0, length: self.textStorage.length))
//
//                    note.save(attributed: attributedText)
//
////                    UIApplication.getVC().notesTable.reloadData()
//                    return
//                }
//            }
//
//            if let image = item["public.jpeg"] as? UIImage, let data = image.jpegData(compressionQuality: 1) {
//                saveImageClipboard(data: data, note: note)
//
//                note.save(attributed: attributedText)
//
////                UIApplication.getVC().notesTable.reloadData()
//                return
//            }
//
//            if let image = item["public.png"] as? UIImage, let data = image.pngData() {
//                saveImageClipboard(data: data, note: note)
//
//                note.save(attributed: attributedText)
//
////                UIApplication.getVC().notesTable.reloadData()
//                return
//            }
//        }

        super.paste(sender)
    }

    override func copy(_ sender: Any?) {
        guard let note = self.note else {
            super.copy(sender)
            return
        }

        let attributedString = NSMutableAttributedString(attributedString: self.textStorage.attributedSubstring(from: self.selectedRange)).unLoadCheckboxes()

        let pathKey = NSAttributedString.Key(rawValue: "co.fluder.fsnotes.image.path")
        if self.selectedRange.length == 1, let path = attributedString.attribute(pathKey, at: 0, effectiveRange: nil) as? String {

//            DispatchQueue.global().async {
//                if let imageUrl = note.getImageUrl(imageName: path),
//                    let data = try? Data(contentsOf: imageUrl),
//                    let image = UIImage(data: data),
//                    let jpgData = image.jpegData(compressionQuality: 1) {
//
//                    UIPasteboard.general.setData(jpgData, forPasteboardType: "public.jpeg")
//                }
//            }

            return
        }

        if self.textStorage.length >= self.selectedRange.upperBound {
            if let rtfd = try? attributedString.data(from: NSMakeRange(0, attributedString.length), documentAttributes: [NSAttributedString.DocumentAttributeKey.documentType:NSAttributedString.DocumentType.rtfd]) {

                UIPasteboard.general.setItems([
                    [kUTTypePlainText as String: attributedString.string],
                    ["es.fsnot.attributed.text": rtfd],
                    [kUTTypeFlatRTFD as String: rtfd]
                ])

                return
            }
        }

        super.copy(sender)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return true
        }

        return super.canPerformAction(action, withSender: sender)
    }
    
    public func initUndoRedoButons() {
//        guard let ea = UIApplication.getEVC().editArea, let um = ea.undoManager else { return }
//        
//        let img = um.canUndo ? undoIcon : undoIcon?.alpha(0.5)
//        let redoImg = um.canRedo ? redoIcon : redoIcon?.alpha(0.5)
//
//        if let scroll = self.inputAccessoryView as? UIScrollView, let toolBar = scroll.subviews.first as? UIToolbar, let items = toolBar.items {
//            for item in items {
//                
//                if item.action == #selector(EditorViewController.undoPressed) {
//                    item.image = img
//                }
//                
//                if item.action == #selector(EditorViewController.redoPressed) {
//                    item.image = redoImg
//                }
//            }
//        }
    }

    public func saveImageClipboard(data: Data, note: Note, ext: String? = nil) {
//        if let path = ImagesProcessor.writeFile(data: data, note: note, ext: ext) {
//            if let imageUrl = note.getImageUrl(imageName: path) {
//
//                let range = NSRange(location: selectedRange.location, length: 1)
//                let attachment = NoteAttachment(editor: self, title: "", path: path, url: imageUrl, note: note)
//
//                if let attributedString = attachment.getAttributedString() {
//
//                    undoManager?.beginUndoGrouping()
//                    textStorage.replaceCharacters(in: selectedRange, with: attributedString)
//                    selectedRange = NSRange(location: selectedRange.location + attributedString.length, length: 0)
//                    undoManager?.endUndoGrouping()
//
//                    let undo = Undo(range: range, string: attributedString)
//                    undoManager?.registerUndo(withTarget: self, selector: #selector(undoImage), object: undo)
//
//                    initUndoRedoButons()
//                    return
//                }
//            }
//        }
    }

    @IBAction func undoImage(_ object: Any) {
        guard let undo = object as? Undo else { return }

        undoManager?.beginUndoGrouping()
        textStorage.replaceCharacters(in: undo.range, with: "")
        undoManager?.endUndoGrouping()

        let range = NSRange(location: undo.range.location, length: 0)
        let redo = Undo(range: range, string: undo.string)

        undoManager?.registerUndo(withTarget: self, selector: #selector(redoImage), object: redo)

        initUndoRedoButons()
    }

    @IBAction func redoImage(_ object: Any) {
        guard let redo = object as? Undo else { return }

        undoManager?.beginUndoGrouping()
        textStorage.replaceCharacters(in: redo.range, with: redo.string)
        selectedRange = NSRange(location: selectedRange.location + redo.string.length, length: 0)
        undoManager?.endUndoGrouping()

        let range = NSRange(location: redo.range.location, length: redo.string.length)
        let undo = Undo(range: range, string: redo.string)

        undoManager?.registerUndo(withTarget: self, selector: #selector(undoImage), object: undo)

        initUndoRedoButons()
    }
    
    public func isTodo(at location: Int) -> Bool {
        let storage = self.textStorage
        
        if storage.length > location, storage.attribute(.todo, at: location, effectiveRange: nil) != nil {
            return true
        }
        
        let range = (storage.string as NSString).paragraphRange(for: NSRange(location: location, length: 0))
        let string = storage.attributedSubstring(from: range).string as NSString
        
        var length = string.range(of: "- [ ]").length
        if length == 0 {
            length = string.range(of: "- [x]").length
        }
        
        if length > 0 {
            let upper = range.location + length
            if location >= range.location && location <= upper {
                return true
            }
        }
        
        return false
    }

    public func isImage(at location: Int) -> Bool {
        let storage = self.textStorage

        let pathKey = NSAttributedString.Key(rawValue: "co.fluder.fsnotes.image.path")

        if storage.length > location, storage.attribute(pathKey, at: location, effectiveRange: nil) != nil {
            return true
        }

        return false
    }

    public func isLink(at location: Int) -> Bool {
        let storage = self.textStorage

        if storage.length > location, storage.attribute(.link, at: location, effectiveRange: nil) != nil {
            return true
        }

        return false
    }

    public func isWikiLink(at location: Int) -> Bool {
        let storage = self.textStorage

        if storage.length > location, 
            let path = storage.attribute(.link, at: location, effectiveRange: nil) as? String,
            path.starts(with: "fsnotes://find?id=") {
            return true
        }

        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // New line
        if text == "\n", let note = self.note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.newLine()

            return false
        }

        // Tab
        if text == "\t", let note = self.note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.tabKey()

            return false
        }

        if let font = self.typingFont {
            self.typingAttributes.removeAll()
            self.typingAttributes[.font] = font
        }

        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        let vc = UIApplication.getVC()
        
        //vc.cloudDriveManager?.metadataQuery.disableUpdates()
        
        guard let note = self.note else { return }
        
//        if isHighlighted {
//            let search = getSearchText()
//            let processor = NotesTextProcessor(storage: textView.textStorage)
//            processor.highlightKeyword(search: search, remove: true)
//            isHighlighted = false
//        }
        
        let range = self.selectedRange
        let storage = self.textStorage
        let processor = NotesTextProcessor(note: note, storage: storage, range: range)
        
        if note.type == .RichText {
            processor.higlightLinks()
        }

        // Prevent textStorage refresh in CloudDriveManager
        note.modifiedLocalAt = Date()
//        self.storageQueue.cancelAllOperations()

        let text = self.attributedText.copy() as? NSAttributedString

        let operation = BlockOperation()
        operation.addExecutionBlock { [weak self] in
            guard let self = self, let text = text else {return}

//            note.saveSync(copy: text)

//            if note.isEncrypted() && !note.isUnlocked() {
//                DispatchQueue.main.async {
//                    self.cancel()
//                }
//
//                return
//            }

//            note.invalidateCache()
//            note.loadPreviewInfo(text: note.content.string)

//            vc.updateSpotlightIndex(notes: [note])

//            DispatchQueue.main.async {
//                self.rowUpdaterTimer.invalidate()
//                self.rowUpdaterTimer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(self.updateCurrentRow), userInfo: nil, repeats: false)
//
//                self.tagsTimer?.invalidate()
//                self.tagsTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.scanTags), userInfo: nil, repeats: false)
//            }

            usleep(100000)
        }
//        self.storageQueue.addOperation(operation)
//
//        editArea.typingAttributes.removeValue(forKey: .backgroundColor)
//        editArea.typingAttributes[.font] = UserDefaultsManagement.noteFont
//        editArea.initUndoRedoButons()
        
        //vc.cloudDriveManager?.metadataQuery.enableUpdates()
    }

    
    @objc func italicPressed(){
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.italic()
        }
    }

    @objc func strikePressed(){
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.strike()
        }
    }

    @objc func underlinePressed(){
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.underline()
        }
    }

    @objc func indentPressed(){
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.tab()
        }
    }
    
    @objc func unIndentPressed(){
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.unTab()
        }
    }
    
    @objc func headerPressed() {
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.header("#")
        }
    }
    
    @objc func boldPressed(){
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.bold()
        }
    }
    
    func linkPressed() {
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.link()
        }
    }
    
    func imagePressed() {
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.image()
        }
    }
    
    func codePressed() {
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.codeBlock()
        }
    }
    
    func quotePressed() {
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.quote()
        }
    }
    
    func listPressed() {
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.list()
        }
    }
    
    func orderedListPressed() {
        if let note = note {
            let formatter = TextFormatter(textView: self, note: note)
            formatter.orderedList()
        }
    }
}

struct Undo {
    var range: NSRange
    var string: NSAttributedString
}

