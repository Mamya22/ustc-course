import socket
import threading
IP = '127.0.0.1'
PORT = 6666
BUFFER_SIZE = 1024

class Client():
    def __init__(self):
        try:
            self.client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.client_socket.connect((IP, PORT))
            print("成功建立连接")
        except Exception:
            print("连接失败，请重新尝试")
            self.client_socket.close()
    
    def receive(self):
        while True:
            try:
                data = self.client_socket.recv(BUFFER_SIZE)
                data = data.decode()
                print("接受消息：", data)
            except:
                break
    
    def send(self):
        try:
            self.client_socket.send("".encode())
            while True:
                message = input()
                try:
                    self.client_socket.send(message.encode())
                    if message == "exit":
                        self.client_socket.close()
                        print("该客户端正在退出")
                        break
                except:
                    break
        except:
            print("未建立连接")
    
client = Client()
try:
    receive_thread = threading.Thread(target=client.receive)
    receive_thread.start()
except:
    print("启动线程失败")
try:
    send_thread = threading.Thread(target=client.send)
    send_thread.start()
except:
    print("启动线程失败")

