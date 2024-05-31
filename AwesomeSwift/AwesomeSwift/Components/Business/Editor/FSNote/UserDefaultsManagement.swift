//
//  UserDefaultsManagement.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import UIKit

public class UserDefaultsManagement {
 
    static var apiPath = "https://api.fsnot.es/"
    static var webPath = "https://p.fsnot.es/"

#if os(OSX)
    typealias Color = NSColor
    typealias Image = NSImage
    typealias Font = NSFont

    public static var shared: UserDefaults? = UserDefaults.standard
    public static var DefaultFontSize = 14
#else
    typealias Color = UIColor
    typealias Image = UIImage
    typealias Font = UIFont

    public static var shared: UserDefaults? = UserDefaults(suiteName: "group.es.fsnot.user.defaults")
    static var DefaultFontSize = 17
#endif

    static var DefaultSnapshotsInterval = 1
    static var DefaultSnapshotsIntervalMinutes = 5
    
    static var DefaultFontColor = Color.black
    static var DefaultBgColor = Color.white
    
    private struct Constants {
        static let AllowTouchID = "allowTouchID"
        static let AppearanceTypeKey = "appearanceType"
        static let AskCommitMessage = "askCommitMessage"
        static let ApiBookmarksData = "apiBookmarksData"
        static let AutoInsertHeader = "autoInsertHeader"
        static let AutoVersioning = "autoVersioning"
        static let AutomaticSpellingCorrection = "automaticSpellingCorrection"
        static let AutomaticQuoteSubstitution = "automaticQuoteSubstitution"
        static let AutomaticDataDetection = "automaticDataDetection"
        static let AutomaticLinkDetection = "automaticLinkDetection"
        static let AutomaticTextReplacement = "automaticTextReplacement"
        static let AutomaticDashSubstitution = "automaticDashSubstitution"
        static let AutomaticConflictsResolution = "automaticConflictsResolution"
        static let BackupManually = "backupManually"
        static let BgColorKey = "bgColorKeyed"
        static let CacheDiff = "cacheDiff"
        static let CellSpacing = "cellSpacing"
        static let CellFrameOriginY = "cellFrameOriginY"
        static let ClickableLinks = "clickableLinks"
        static let CodeFontNameKey = "codeFont"
        static let CodeFontSizeKey = "codeFontSize"
        static let codeBlockHighlight = "codeBlockHighlight"
        static let CodeBlocksWithSyntaxHighlighting = "codeBlocksWithSyntaxHighlighting"
        static let codeTheme = "codeTheme"
        static let ContinuousSpellChecking = "continuousSpellChecking"
        static let CrashedLastTime = "crashedLastTime"
        static let CustomWebServer = "customWebServer"
        static let DefaultLanguageKey = "defaultLanguage"
        static let FontNameKey = "font"
        static let FontSizeKey = "fontsize"
        static let FontColorKey = "fontColorKeyed"
        static let FullScreen = "fullScreen"
        static let FirstLineAsTitle = "firstLineAsTitle"
        static let NoteType = "noteType"
        static let NoteExtension = "noteExtension"
        static let GrammarChecking = "grammarChecking"
        static let GitStorage = "gitStorage"
        static let GitUsername = "gitUsername"
        static let GitPassword = "gitPassword"
        static let GitOrigin = "gitOrigin"
        static let GitPrivateKeyData = "gitPrivateKeyData"
        static let GitPasspharse = "gitPasspharse"
        static let HideDate = "hideDate"
        static let HideOnDeactivate = "hideOnDeactivate"
        static let HideSidebar = "hideSidebar"
        static let HidePreviewKey = "hidePreview"
        static let HidePreviewImages = "hidePreviewImages"
        static let iCloudDrive = "iCloudDrive"
        static let ImagesWidthKey = "imagesWidthKey"
        static let IndentedCodeBlockHighlighting = "IndentedCodeBlockHighlighting"
        static let IndentUsing = "indentUsing"
        static let InlineTags = "inlineTags"
        static let LastCommitMessage = "lastCommitMessage"
        static let LastNews = "lastNews"
        static let LastSelectedPath = "lastSelectedPath"
        static let LastScreenX = "lastScreenX"
        static let LastScreenY = "lastScreenY"
        static let LastSidebarItem = "lastSidebarItem"
        static let LastProjectURL = "lastProjectUrl"
        static let LineSpacingEditorKey = "lineSpacingEditor"
        static let LineWidthKey = "lineWidth"
        static let LiveImagesPreview = "liveImagesPreview"
        static let LockOnSleep = "lockOnSleep"
        static let LockOnScreenActivated = "lockOnScreenActivated"
        static let LockAfterIDLE = "lockAfterIdle"
        static let LockAfterUserSwitch = "lockAfterUserSwitch"
        static let MarginSizeKey = "marginSize"
        static let MasterPasswordHint = "masterPasswordHint"
        static let MathJaxPreview = "mathJaxPreview"
        static let NightModeType = "nightModeType"
        static let NightModeAuto = "nightModeAuto"
        static let NightModeBrightnessLevel = "nightModeBrightnessLevel"
        static let NonContiguousLayout = "allowsNonContiguousLayout"
        static let NoteContainer = "noteContainer"
        static let Preview = "preview"
        static let PreviewFontSize = "previewFontSize"
        static let ProjectsKey = "projects"
        static let ProjectsKeyNew = "ProjectsKeyNew"
        static let RecentSearches = "recentSearches"
        static let PullInterval = "pullInterval"
        static let SaveInKeychain = "saveInKeychain"
        static let SearchHighlight = "searchHighlighting"
        static let SeparateRepo = "separateRepo"
        static let SftpHost = "sftpHost"
        static let SftpPort = "sftpPort"
        static let SftpPath = "sftpPath"
        static let SftpPasspharse = "sftpPassphrase"
        static let SftpWeb = "sftpWeb"
        static let SftpUsername = "sftpUsername"
        static let SftpPassword = "sftpPassword"
        static let SftpKeysAccessData = "sftpKeysAccessData"
        static let SftpUploadBookmarksData = "sftpUploadBookmarksData"
        static let SharedContainerKey = "sharedContainer"
        static let ShowDockIcon = "showDockIcon"
        static let shouldFocusSearchOnESCKeyDown = "shouldFocusSearchOnESCKeyDown"
        static let ShowInMenuBar = "showInMenuBar"
        static let SmartInsertDelete = "smartInsertDelete"
        static let SnapshotsInterval = "snapshotsInterval"
        static let SnapshotsIntervalMinutes = "snapshotsIntervalMinutes"
        static let SortBy = "sortBy"
        static let SoulverPreview = "soulverPreview"
        static let StorageType = "storageType"
        static let StoragePathKey = "storageUrl"
        static let TableOrientation = "isUseHorizontalMode"
        static let TextMatchAutoSelection = "textMatchAutoSelection"
        static let TrashKey = "trashKey"
        static let UploadKey = "uploadKey"
        static let AutocloseBrackets = "autocloseBrackets"
        static let Welcome = "welcome"
        
        static let appIcon = "appIcon"
        static let currentNote = "currentNote"
        static let currentLocation = "currentLocation"
        static let currentLength = "currentLength"
        static let dynamicTypeFont = "dynamicTypeFont"
        static let editorAutocorrection = "editorAutocorrection"
        static let editorState = "editorState"
        static let editorSuggestions = "editorSuggestions"
        static let IsFirstLaunch = "isFirstLaunch"
        static let ImportURLsKey = "ImportURLs"
    }

    static var codeFontName: String {
        get {
            if let returnFontName = shared?.object(forKey: Constants.CodeFontNameKey) {
                return returnFontName as! String
            } else {
                return "Source Code Pro"
            }
        }
        set {
            shared?.set(newValue, forKey: Constants.CodeFontNameKey)
        }
    }

    static var codeFontSize: Int {
        get {
            if let returnFontSize = shared?.object(forKey: Constants.CodeFontSizeKey) {
                return returnFontSize as! Int
            } else {
                return self.DefaultFontSize
            }
        }
        set {
            shared?.set(newValue, forKey: Constants.CodeFontSizeKey)
        }
    }
    
    static var indentUsing: Int {
        get {
            if let result = shared?.integer(forKey: Constants.IndentUsing) {
                return result
            }

            return 0
        }
        set {
            shared?.set(newValue, forKey: Constants.IndentUsing)
        }
    }

    static var fontName: String? {
        get {
            if let returnFontName = shared?.object(forKey: Constants.FontNameKey) as? String {
                return returnFontName
            }

            return nil
        }
        set {
            shared?.set(newValue, forKey: Constants.FontNameKey)
        }
    }
    
    static var fontSize: Int {
        get {
            if let returnFontSize = shared?.object(forKey: Constants.FontSizeKey) as? Int {
                return returnFontSize
            } else {
                return self.DefaultFontSize
            }
        }
        set {
            shared?.set(newValue, forKey: Constants.FontSizeKey)
        }
    }
    
    static var externalEditor: String {
        get {
            let name = shared?.object(forKey: "externalEditorApp")
            if name != nil && (name as! String).count > 0 {
                return name as! String
            } else {
                return "TextEdit"
            }
        }
        set {
            shared?.set(newValue, forKey: "externalEditorApp")
        }
    }

    static var horizontalOrientation: Bool {
        get {
            if let returnMode = shared?.object(forKey: Constants.TableOrientation) {
                return returnMode as! Bool
            } else {
                return false
            }
        }
        set {
            shared?.set(newValue, forKey: Constants.TableOrientation)
        }
    }
    
    static var dynamicTypeFont: Bool {
        get {
            if let result = shared?.object(forKey: Constants.dynamicTypeFont) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.dynamicTypeFont)
        }
    }
    
    static var editorLineSpacing: Float {
        get {
            if let result = shared?.object(forKey: Constants.LineSpacingEditorKey) as? Float {
                return Float(Int(result))
            } else {
                #if os(iOS)
                    return 6
                #else
                    return 4
                #endif
            }
        }
        set {
            shared?.set(newValue, forKey: Constants.LineSpacingEditorKey)
        }
    }

    static var clickableLinks: Bool {
        get {
            if let highlight = shared?.object(forKey: Constants.ClickableLinks) {
                return highlight as! Bool
            }
            
            #if os(iOS)
                return true
            #else
                return false
            #endif
        }
        set {
            shared?.set(newValue, forKey: Constants.ClickableLinks)
        }
    }
    
    static var fullScreen: Bool {
        get {
            if let result = shared?.object(forKey: Constants.FullScreen) as? Bool {
                return result
            }
            return false
        }
        set {
            shared?.set(newValue, forKey: Constants.FullScreen)
        }
    }

    static var inlineTags: Bool {
        get {
            if let result = shared?.object(forKey: Constants.InlineTags) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.InlineTags)
        }
    }
    
    static var mathJaxPreview: Bool {
        get {
            if let result = shared?.object(forKey: Constants.MathJaxPreview) as? Bool {
                return result
            }

            return false
        }
        set {
            shared?.set(newValue, forKey: Constants.MathJaxPreview)
        }
    }
    
    static var soulverPreview: Bool {
        get {
            if #unavailable(OSX 10.15, iOS 14.0) {
                return false
            }
            
            if let result = shared?.object(forKey: Constants.SoulverPreview) as? Bool {
                return result
            }

            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.SoulverPreview)
        }
    }

    static var sidebarVisibilityInbox: Bool {
        get {
            if let result = shared?.object(forKey: "sidebarVisibilityInbox") as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: "sidebarVisibilityInbox")
        }
    }

    static var sidebarVisibilityNotes: Bool {
        get {
            if let result = shared?.object(forKey: "sidebarVisibilityNotes") as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: "sidebarVisibilityNotes")
        }
    }

    static var sidebarVisibilityTodo: Bool {
        get {
            if let result = shared?.object(forKey: "sidebarVisibilityTodo") as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: "sidebarVisibilityTodo")
        }
    }

    static var sidebarVisibilityUntagged: Bool {
        get {
            if let result = shared?.object(forKey: "sidebarVisibilityUntagged") as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: "sidebarVisibilityUntagged")
        }
    }

    static var sidebarVisibilityTrash: Bool {
        get {
            if let result = shared?.object(forKey: "sidebarVisibilityTrash") as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: "sidebarVisibilityTrash")
        }
    }

    static var crashedLastTime: Bool {
        get {
            if let result = shared?.object(forKey: Constants.CrashedLastTime) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.CrashedLastTime)
        }
    }

    static var lastNews: Date? {
        get {
            if let sync = shared?.object(forKey: "lastNews") {
                return sync as? Date
            } else {
                return nil
            }
        }
        set {
            shared?.set(newValue, forKey: "lastNews")
        }
    }

    static var autoInsertHeader: Bool {
        get {
            if let result = shared?.object(forKey: Constants.AutoInsertHeader) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.AutoInsertHeader)
        }
    }

    static var nonContiguousLayout: Bool {
        get {
            if let result = shared?.object(forKey: Constants.NonContiguousLayout), let data = result as? Bool {
                return data
            }

            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.NonContiguousLayout)
        }
    }

    static var codeBlocksWithSyntaxHighlighting: Bool {
        get {
            if let result = shared?.object(forKey: Constants.CodeBlocksWithSyntaxHighlighting) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.CodeBlocksWithSyntaxHighlighting)
        }
    }

    static var lastScreenX: Int? {
        get {
            if let value = shared?.object(forKey: Constants.LastScreenX) as? Int {
                return value
            }

            return nil
        }
        set {
            shared?.set(newValue, forKey: Constants.LastScreenX)
        }
    }

    static var lastScreenY: Int? {
        get {
            if let value = shared?.object(forKey: Constants.LastScreenY) as? Int {
                return value
            }

            return nil
        }
        set {
            shared?.set(newValue, forKey: Constants.LastScreenY)
        }
    }

    static var recentSearches: [String]? {
        get {
            if let value = shared?.array(forKey: Constants.RecentSearches) as? [String] {
                return value
            }

            return nil
        }
        set {
            shared?.set(newValue, forKey: Constants.RecentSearches)
        }
    }

    static var searchHighlight: Bool {
        get {
            if let result = shared?.object(forKey: Constants.SearchHighlight) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.SearchHighlight)
        }
    }

    static var autoVersioning: Bool {
        get {
            if let result = shared?.object(forKey: Constants.AutoVersioning) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.AutoVersioning)
        }
    }
    
    static var iCloudDrive: Bool {
        get {
            if let result = shared?.object(forKey: Constants.iCloudDrive) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.iCloudDrive)
        }
    }
    
    static var customWebServer: Bool {
        get {
            if let result = shared?.object(forKey: Constants.CustomWebServer) as? Bool {
                return result
            }
            return false
        }
        set {
            shared?.set(newValue, forKey: Constants.CustomWebServer)
        }
    }
    
    static var sftpHost: String {
        get {
            if let result = shared?.object(forKey: Constants.SftpHost) as? String {
                return result
            }

            return ""
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpHost)
        }
    }
    
    static var sftpPort: Int32 {
        get {
            if let result = shared?.object(forKey: Constants.SftpPort) as? Int32 {
                return result
            }

            return 22
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpPort)
        }
    }
    
    static var sftpUsername: String {
        get {
            if let result = shared?.object(forKey: Constants.SftpUsername) as? String {
                return result
            }

            return ""
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpUsername)
        }
    }
    
    static var sftpPassword: String {
        get {
            if let result = shared?.object(forKey: Constants.SftpPassword) as? String {
                return result
            }

            return ""
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpPassword)
        }
    }
    
    static var sftpPath: String? {
        get {
            if let result = shared?.object(forKey: Constants.SftpPath) as? String {
                if result.count == 0 {
                    return nil
                }
                
                let suffix = result.hasSuffix("/") ? "" : "/"
                return result + suffix
            }

            return nil
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpPath)
        }
    }
    
    static var sftpPassphrase: String {
        get {
            if let result = shared?.object(forKey: Constants.SftpPasspharse) as? String {
                return result
            }

            return ""
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpPasspharse)
        }
    }
    
    static var noteExtension: String {
        get {
            if let result = shared?.object(forKey: Constants.NoteExtension) as? String {
                return result
            }

            return "markdown"
        }
        set {
            shared?.set(newValue, forKey: Constants.NoteExtension)
        }
    }
    
    static var sftpWeb: String? {
        get {
            if let result = shared?.object(forKey: Constants.SftpWeb) as? String {
                if result.count == 0 {
                    return nil
                }
                
                if result.last != "/" {
                    return result + "/"
                }
                
                return result
            }

            return nil
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpWeb)
        }
    }
    
    static var sftpAccessData: Data? {
        get {
            return shared?.data(forKey: Constants.SftpKeysAccessData)
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpKeysAccessData)
        }
    }
    
    static var sftpUploadBookmarksData: Data? {
        get {
            return shared?.data(forKey: Constants.SftpUploadBookmarksData)
        }
        set {
            shared?.set(newValue, forKey: Constants.SftpUploadBookmarksData)
        }
    }
    
    static var apiBookmarksData: Data? {
        get {
            return shared?.data(forKey: Constants.ApiBookmarksData)
        }
        set {
            shared?.set(newValue, forKey: Constants.ApiBookmarksData)
        }
    }
    
    static var gitPrivateKeyData: Data? {
        get {
            return shared?.data(forKey: Constants.GitPrivateKeyData)
        }
        set {
            shared?.set(newValue, forKey: Constants.GitPrivateKeyData)
        }
    }
    
    static var gitPassphrase: String {
        get {
            if let result = shared?.object(forKey: Constants.GitPasspharse) as? String {
                return result
            }

            return ""
        }
        set {
            shared?.set(newValue, forKey: Constants.GitPasspharse)
        }
    }
    
    static var trashURL: URL? {
        get {
            if let trashUrl = shared?.url(forKey: Constants.TrashKey) {
                return trashUrl
            }

            return nil
        }
        set {
            shared?.set(newValue, forKey: Constants.TrashKey)
        }
    }
    
    static var separateRepo: Bool {
        get {
            if let result = shared?.object(forKey: Constants.SeparateRepo) as? Bool {
                return result
            }
            return false
        }
        set {
            shared?.set(newValue, forKey: Constants.SeparateRepo)
        }
    }
    
    static var askCommitMessage: Bool {
        get {
            if let result = shared?.object(forKey: Constants.AskCommitMessage) as? Bool {
                return result
            }
            return false
        }
        set {
            shared?.set(newValue, forKey: Constants.AskCommitMessage)
        }
    }
    
    static var lastCommitMessage: String? {
        get {
            if let result = shared?.object(forKey: Constants.LastCommitMessage) as? String, result.count > 0 {
                return result
            }
            
            return nil
        }
        
        set {
            shared?.set(newValue, forKey: Constants.LastCommitMessage)
        }
    }
    
    static var lightCodeTheme: String {
        get {
            if let theme = UserDefaults.standard.object(forKey: Constants.codeTheme) as? String {
                return theme
            }

            return "github"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.codeTheme)
        }
    }
    
    static var projects: [URL] {
        get {
            guard let defaults = UserDefaults.init(suiteName: "group.es.fsnot.user.defaults") else { return [] }

            if let data = defaults.data(forKey: Constants.ProjectsKeyNew), let urls = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSURL.self], from: data) as? [URL] {
                return urls
            }

            return []
        }
        set {
            guard let defaults = UserDefaults.init(suiteName: "group.es.fsnot.user.defaults") else { return }

            if let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) {
                defaults.set(data, forKey: Constants.ProjectsKeyNew)
            }
        }
    }
    
    static var liveImagesPreview: Bool {
        get {
            if let result = shared?.object(forKey: Constants.LiveImagesPreview) {
                return result as! Bool
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.LiveImagesPreview)
        }
    }
    
    static var codeBlockHighlight: Bool {
        get {
            if let highlight = shared?.object(forKey: Constants.codeBlockHighlight) {
                return highlight as! Bool
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.codeBlockHighlight)
        }
    }

    static var indentedCodeBlockHighlighting: Bool {
        get {
            if let highlight = shared?.object(forKey: Constants.IndentedCodeBlockHighlighting) {
                return highlight as! Bool
            }
            return false
        }
        set {
            shared?.set(newValue, forKey: Constants.IndentedCodeBlockHighlighting)
        }
    }

    
}

extension UserDefaultsManagement {
    
    static var editorAutocorrection: Bool {
        get {
            if let result = shared?.object(forKey: Constants.editorAutocorrection) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.editorAutocorrection)
        }
    }

    static var editorSpellChecking: Bool {
        get {
            if let result = shared?.object(forKey: Constants.editorSuggestions) as? Bool {
                return result
            }
            return true
        }
        set {
            shared?.set(newValue, forKey: Constants.editorSuggestions)
        }
    }
    
    static var noteFont: UIFont {
        get {
            if #available(iOS 11.0, *), UserDefaultsManagement.dynamicTypeFont {
                var font = UIFont.systemFont(ofSize: CGFloat(DefaultFontSize))

                if let fontName = UserDefaultsManagement.fontName,
                    let currentFont = UIFont(name: fontName, size: CGFloat(DefaultFontSize)) {
                    font = currentFont
                }

                let fontMetrics = UIFontMetrics(forTextStyle: .body)
                return fontMetrics.scaledFont(for: font)
            }

            if let name = self.fontName, name.starts(with: ".") {
                return UIFont.systemFont(ofSize: CGFloat(self.fontSize))
            }

            if let fontName = self.fontName, let font = UIFont(name: fontName, size: CGFloat(self.fontSize)) {
                return font
            }

            return UIFont.systemFont(ofSize: CGFloat(self.fontSize))
        }
        set {
            self.fontName = newValue.fontName
            self.fontSize = Int(newValue.pointSize)
        }
    }

    static var codeFont: UIFont {
        get {
            if #available(iOS 11.0, *), UserDefaultsManagement.dynamicTypeFont {
                var font = Font.systemFont(ofSize: CGFloat(self.codeFontSize))

                if let currentFont = Font(name: self.codeFontName, size: CGFloat(self.codeFontSize)) {
                    font = currentFont
                }

                let fontMetrics = UIFontMetrics(forTextStyle: .body)
                return fontMetrics.scaledFont(for: font)
            }

            if let font = UIFont(name: self.codeFontName, size: CGFloat(self.codeFontSize)) {
                return font
            }

            return UIFont.systemFont(ofSize: CGFloat(self.codeFontSize))
        }
        set {
            self.codeFontName = newValue.familyName
            self.codeFontSize = Int(newValue.pointSize)
        }
    }
    
    static var fontColor: Color {
        get {
            return self.DefaultFontColor
        }
    }

    static var bgColor: Color {
        get {
            return self.DefaultBgColor
        }
    }
    
    static var codeTheme: String {
        get {
            if let theme = shared?.object(forKey: Constants.codeTheme) as? String {
                return theme
            }

            if UITraitCollection.current.userInterfaceStyle == .dark {
                return "monokai-sublime"
            }

            return "github"
        }
        set {
            shared?.set(newValue, forKey: Constants.codeTheme)
        }
    }
}
