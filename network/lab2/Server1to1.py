import socket
import threading
import queue
import time
import sys
import signal

IP = '127.0.0.1'
PORT = 6666
BUFFER_SIZE = 6666
messages = queue.Queue()

class Server():
    def __init__(self):
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.bind((IP, PORT))
    
    def receive(self, conn, addr):
        while True:
            self.msg = conn.recv(BUFFER_SIZE).decode()
            print("接收消息： ",self.msg)
            if self.msg == "exit":
                conn.close()
                break
    
    def send(self,conn):
        while True:
            try:
                msg = input()
                conn.send(msg.encode())
            except:
                print("服务器端中断连接")
                break
    def accept_client(self):
        while True:
            try:
                conn, addr = self.socket.accept()
                thread = threading.Thread(target=self.receive, args=(conn, addr))
                thread.start()
                thread2 = threading.Thread(target=self.send, args=(conn,))
                thread2.start()
                print("与服务器建立连接")
            except:
                break
    def run(self):
        self.socket.listen(10)
        accept_thread = threading.Thread(target=self.accept_client,daemon=True)
        accept_thread.start()
        # 定义关闭服务器的操作
        def shutdown_server(signum, frame):
            print("正在关闭服务器")
            self.socket.close()
            sys.exit(0)
        signal.signal(signal.SIGINT, shutdown_server)
        signal.signal(signal.SIGTERM, shutdown_server)
        print("请按Ctrl+C终止服务器")
        while True:
            try:
                # 主线程等待信号
                time.sleep(1) # 等待信号到来
            except KeyboardInterrupt:
                pass

server = Server()
server.run()
