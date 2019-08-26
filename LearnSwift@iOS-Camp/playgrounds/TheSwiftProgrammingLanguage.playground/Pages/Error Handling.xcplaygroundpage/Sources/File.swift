import Foundation

public func open(_ filePath: String) -> File {
    return File(lines: Int.random(in: 1...10))
}

public func exists(_ filePath: String) -> Bool { return Bool.random() }
public func close(_ file: File) {}

public class File {
    public struct Line {
        public let number: Int
    }
    
    public init(lines: Int) {
        self.lines = lines
    }

    private let lines: Int
    private var currentLine = 1
    
    public func readline() throws -> Line? {
        defer {
            currentLine += 1
        }
        
        return currentLine != lines ? Line(number: currentLine) : nil
    }
}
