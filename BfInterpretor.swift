public protocol BfInterpreter {
    init(src: String) throws
    func run() throws
}

public enum ProgramError: ErrorType {
    case OverRun
    case BracketsTooMany(Int)
}