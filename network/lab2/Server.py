import socket
import threading
import queue
import signal
import sys
import time
IP = '127.0.0.1'
PORT = 6666
BUFFER_SIZE = 6666
messages = queue.Queue()

clients = {}
# i = 1
server_running = True
class Server():
    global i, clients
    def __init__(self):
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.bind((IP, PORT))
        self.socket.listen(10)
    
    def receive(self,  user,conn, addr):
        while True:
            try:
                msg = conn.recv(BUFFER_SIZE).decode()
                print("接收消息： ",msg)
            except:
                print("线程中断")
                break
            if msg[0] == "@":
                name = msg.split(' ')[0][1:]
                if name in clients.keys():
                    (client, client_addr) = clients[name]
                    index = msg.find(' ')
                    print(msg[index+1:])
                    client.send((f"用户{user}私聊: "+msg[index+1:]).encode())
                    conn.send((f"用户{user}私聊: "+msg[index+1:]).encode())
                else:
                    conn.send(f"不存在用户名为{name}的用户".encode())
            else:
                if msg == 'exit':
                    conn.close()
                    clients.pop(user)
                    break
                else:
                    self.broadcast(user, msg)

    def broadcast(self, user, message):
        for name, client in clients.items():
            client[0].send((f"用户{user}:" + message).encode())
    
    def accept_client(self):
        while True:
            try:
                conn, addr = self.socket.accept()
                msg = conn.recv(BUFFER_SIZE).decode()
                username = msg[9:]
                # 为每个用户编号
                # 将用户信息存储
                while True:
                    if username in clients.keys():
                        conn.send("该用户名已存在，请重新输入")
                    else:
                        clients[username] = (conn, addr)
                        break
                msg = "Welcome"
                conn.send(msg.encode())
                print(f"与用户{username}建立连接")
                # 发送消息的线程
                thread = threading.Thread(target=self.receive, args=(username, conn, addr))
                thread.start()
            except:
                break
        
    def run(self):
        accept_thread = threading.Thread(target=self.accept_client,daemon=True)
        accept_thread.start()
        # 定义关闭服务器的操作
        def shutdown_server(signum, frame):
            print("正在关闭服务器")
            for user,(conn, _) in clients.items():
                conn.send("服务器关闭".encode())
                conn.close()
            clients.clear()
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