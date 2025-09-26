

class Test:
    def __init__(self):
        pass
    
    def __del__(self):
        print("Fuck")
# driver function
if __name__ == '__main__':
    test = Test()
    print("Program End")