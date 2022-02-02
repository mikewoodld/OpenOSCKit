//
//  OSCBundle.swift
//  OpenOSCKit
//
//  Created by Sam Smallman on 29/10/2017.
//  Copyright © 2020 Sam Smallman. https://github.com/SammySmallman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

public class OSCBundle: OSCPacket {
    
    public var timeTag: OSCTimeTag = OSCTimeTag()
    public var elements: [OSCPacket] = []
    public var replySocket: OSCSocket?
    
    public init(with elements: [OSCPacket] = []) {
        bundle(with: elements, timeTag: OSCTimeTag.init())
    }
    
    public init(with elements: [OSCPacket] = [], timeTag: OSCTimeTag) {
        bundle(with: elements, timeTag: timeTag)
    }
    
    public init(with elements: [OSCPacket] = [], timeTag: OSCTimeTag, replySocket: OSCSocket?) {
        bundle(with: elements, timeTag: timeTag, replySocket: replySocket)
    }
    
    private func bundle(with elements: [OSCPacket] = [], timeTag: OSCTimeTag, replySocket: OSCSocket? = nil) {
        self.timeTag = timeTag
        self.elements = elements
        self.replySocket = replySocket
    }
    
    public func packetData()->Data {
        var result = "#bundle".oscStringData()
        let timeTagData = self.timeTag.oscTimeTagData()
        result.append(timeTagData)
        for element in elements {
            if element is OSCMessage {
                let data = (element as! OSCMessage).packetData()
                let size = withUnsafeBytes(of: Int32(data.count).bigEndian) { Data($0) }
                result.append(size)
                result.append(data)
            }
            if element is OSCBundle {
                let data = (element as! OSCBundle).packetData()
                let size = withUnsafeBytes(of: Int32(data.count).bigEndian) { Data($0) }
                result.append(size)
                result.append(data)
            }
        }
        return result
    }
    
}

