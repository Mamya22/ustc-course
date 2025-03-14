import socket
import threading
IP = '127.0.0.1'
PORT = 6666
BUFFER_SIZE = 1024

print("建立连接")
class Client():
    def __init__(self):
        try:
            self.client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.client_socket.connect((IP, PORT))
            while True:
                name = input('请输入用户名：')
                self.client_socket.send(("username:"+ name).encode())
                msg = self.client_socket.recv(BUFFER_SIZE).decode()
                if msg == 'Welcome':
                    print("Welcome")
                    print("成功建立连接")
                    print("若想要私聊用户，则格式为@username （有空格）")
                    break
        except Exception:
            print("连接失败，请重新尝试")
            self.client_socket.close()
    def receive(self):
        while True:
            try:
                data = self.client_socket.recv(BUFFER_SIZE)
                data = data.decode()
                print(data)
            except:
                # if self.client_socket.shutdown
                print("断开连接")
                break
    
    def send(self):
        while True:
            message = input()
            try:
                self.client_socket.send(message.encode())
                if message == "exit":
                    self.client_socket.close()
                    print("该客户端已退出")
                    break
            except:
                break

client = Client()

receive_thread = threading.Thread(target=client.receive)
receive_thread.start()

send_thread = threading.Thread(target=client.send)
send_thread.start()