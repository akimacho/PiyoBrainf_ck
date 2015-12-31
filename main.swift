import Foundation

func getSrc(argv: [String]) -> String {
    let argc = argv.count
    if argc == 1 {
        let src = readLine()
        return src!
    } else if argc == 2 {
        let srcPath = Process.arguments[1]
        let fileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(srcPath) {
            do {
                let src = try String(contentsOfFile: srcPath, encoding: NSUTF8StringEncoding)
                return src
            } catch let error as NSError {
                print("Error: \(error)")
                exit(EXIT_FAILURE)
            }
        } else {
            perror(srcPath)
            exit(EXIT_FAILURE)
        }
    } else {
        print("\(Process.arguments.first!) [filename]")
        exit(EXIT_FAILURE)
    }
}

do {
    let src = getSrc(Process.arguments)
    let brainf_ck = try Brainf_ck(src: src)
    try brainf_ck.run()
} catch ProgramError.OverRun {
    print("Can't move to left than start point")
    exit(EXIT_FAILURE)
} catch ProgramError.BracketsTooMany(let code) {
    if code == 0 {
        print("\"]\" too many")
    } else if code == 1 {
        print("\"[\" too many")
    }
    exit(EXIT_FAILURE)
}