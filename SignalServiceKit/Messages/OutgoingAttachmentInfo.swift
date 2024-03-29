//
// Copyright 2023 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import Foundation

public final class OutgoingAttachmentInfo {
    let dataSource: DataSource
    let contentType: String
    let sourceFilename: String?
    let caption: String?
    let albumMessageId: String?
    let renderingFlag: AttachmentReference.RenderingFlag

    public init(
        dataSource: DataSource,
        contentType: String,
        sourceFilename: String? = nil,
        caption: String? = nil,
        albumMessageId: String? = nil,
        isBorderless: Bool = false,
        isVoiceMessage: Bool = false,
        isLoopingVideo: Bool = false
    ) {
        self.dataSource = dataSource
        self.contentType = contentType
        self.sourceFilename = sourceFilename
        self.caption = caption
        self.albumMessageId = albumMessageId
        self.renderingFlag = {
            if isVoiceMessage {
                return .voiceMessage
            } else if isBorderless {
                return .borderless
            } else if isLoopingVideo || MIMETypeUtil.isDefinitelyAnimated(contentType) {
                return .shouldLoop
            } else {
                return .default
            }
        }()
    }

    public func asAttachmentDataSource() -> TSResourceDataSource {
        return .from(
            dataSource: dataSource,
            mimeType: contentType,
            caption: caption.map { MessageBody(text: $0, ranges: .empty) },
            renderingFlag: renderingFlag
        )
    }

    public func asLegacyAttachmentDataSource() -> TSAttachmentDataSource {
        return .init(
            mimeType: contentType,
            caption: caption.map { MessageBody(text: $0, ranges: .empty) },
            renderingFlag: renderingFlag,
            sourceFilename: dataSource.sourceFilename,
            dataSource: .dataSource(dataSource, shouldCopy: false)
        )
    }
}
