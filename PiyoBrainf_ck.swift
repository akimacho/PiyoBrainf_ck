public class Brainf_ck: BfInterpreter {
    var src = ""
    var tokens: [Character] = []
    var jumps: [Int:Int] = [:]
    var pc = 0
    var cur = 0
    var tape: [Int] = []
    
    required public init(src: String) throws {
        self.src = src
        self.tokens = Array(src.characters).filter({ (ch: Character) -> Bool in
            return ch != " "
        })
        self.jumps = try analyzeJumps()
    }
    public func run() throws {
        while pc < tokens.count {
            switch tokens[pc] {
            case "+":
                if tape.count == cur {
                    tape.append(0)
                }
                tape[cur]++
            case "-":
                if tape.count == cur {
                    tape.append(0)
                }
                tape[cur]--
            case ">":
                cur++
            case "<":
                cur--
                if cur < 0 {
                    throw ProgramError.OverRun
                }
            case ".":
                if tape.count == cur {
                    tape.append(0)
                }
                let ch = Character(UnicodeScalar(tape[cur]))
                print(ch, terminator: "")
            case ",":
                if tape.count == cur {
                    tape.append(0)
                }
                let line = readLine()
                let ch = line![(line?.startIndex)!]
                let s = String(ch).unicodeScalars
                tape[cur] = Int(s[s.startIndex].value)
            case "[":
                if tape.count == cur {
                    tape.append(0)
                }
                if tape[cur] == 0 {
                    pc = jumps[pc]!
                }
            case "]":
                if tape[cur] != 0 {
                    pc = jumps[pc]!
                }
            default:
                break
            }
            
            pc++
        }
    }
    
    private func analyzeJumps() throws -> [Int:Int] {
        var table: [Int:Int] = [:]
        var starts: [Int] = []
        
        for var i = 0; i < tokens.count; i++ {
            if tokens[i] == "[" {
                starts.append(i)
            } else if tokens[i] == "]" {
                guard !starts.isEmpty else {
                    throw ProgramError.BracketsTooMany(1)
                }
                let from = starts.removeLast()
                let to = i
                table[from] = to
                table[to] = from
            }
        }
        guard starts.isEmpty else {
            throw ProgramError.BracketsTooMany(0)
        }
        
        return table
    }
}
