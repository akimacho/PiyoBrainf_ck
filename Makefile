TARGET = brainf_ck
brainf_ck: main.swift
	xcrun -sdk macosx swiftc -o $(TARGET) PiyoBrainf_ck.swift BfInterpretor.swift main.swift
clean: 
	rm -rf $(TARGET)
