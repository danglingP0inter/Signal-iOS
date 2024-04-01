//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoStandardMessage in Backup.proto
import Wire

public struct BackupProtoStandardMessage {

    public var quote: BackupProtoQuote?
    public var text: BackupProtoText?
    public var attachments: [BackupProtoFilePointer] = []
    public var linkPreview: [BackupProtoLinkPreview] = []
    @ProtoDefaulted
    public var longText: BackupProtoFilePointer?
    public var reactions: [BackupProtoReaction] = []
    public var unknownFields: UnknownFields = .init()

    public init(configure: (inout Self) -> Swift.Void = { _ in }) {
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoStandardMessage : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoStandardMessage : Hashable {
}
#endif

extension BackupProtoStandardMessage : Sendable {
}

extension BackupProtoStandardMessage : ProtoDefaultedValue {

    public static var defaultedValue: BackupProtoStandardMessage {
        BackupProtoStandardMessage()
    }
}

extension BackupProtoStandardMessage : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoStandardMessage"
    }

}

extension BackupProtoStandardMessage : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var quote: BackupProtoQuote? = nil
        var text: BackupProtoText? = nil
        var attachments: [BackupProtoFilePointer] = []
        var linkPreview: [BackupProtoLinkPreview] = []
        var longText: BackupProtoFilePointer? = nil
        var reactions: [BackupProtoReaction] = []

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: quote = try protoReader.decode(BackupProtoQuote.self)
            case 2: text = try protoReader.decode(BackupProtoText.self)
            case 3: try protoReader.decode(into: &attachments)
            case 4: try protoReader.decode(into: &linkPreview)
            case 5: longText = try protoReader.decode(BackupProtoFilePointer.self)
            case 6: try protoReader.decode(into: &reactions)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self.quote = quote
        self.text = text
        self.attachments = attachments
        self.linkPreview = linkPreview
        self._longText.wrappedValue = longText
        self.reactions = reactions
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.quote)
        try protoWriter.encode(tag: 2, value: self.text)
        try protoWriter.encode(tag: 3, value: self.attachments)
        try protoWriter.encode(tag: 4, value: self.linkPreview)
        try protoWriter.encode(tag: 5, value: self.longText)
        try protoWriter.encode(tag: 6, value: self.reactions)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoStandardMessage : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.quote = try container.decodeIfPresent(BackupProtoQuote.self, forKey: "quote")
        self.text = try container.decodeIfPresent(BackupProtoText.self, forKey: "text")
        self.attachments = try container.decodeProtoArray(BackupProtoFilePointer.self, forKey: "attachments")
        self.linkPreview = try container.decodeProtoArray(BackupProtoLinkPreview.self, forKey: "linkPreview")
        self._longText.wrappedValue = try container.decodeIfPresent(BackupProtoFilePointer.self, forKey: "longText")
        self.reactions = try container.decodeProtoArray(BackupProtoReaction.self, forKey: "reactions")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        try container.encodeIfPresent(self.quote, forKey: "quote")
        try container.encodeIfPresent(self.text, forKey: "text")
        if includeDefaults || !self.attachments.isEmpty {
            try container.encodeProtoArray(self.attachments, forKey: "attachments")
        }
        if includeDefaults || !self.linkPreview.isEmpty {
            try container.encodeProtoArray(self.linkPreview, forKey: "linkPreview")
        }
        try container.encodeIfPresent(self.longText, forKey: "longText")
        if includeDefaults || !self.reactions.isEmpty {
            try container.encodeProtoArray(self.reactions, forKey: "reactions")
        }
    }

}
#endif
