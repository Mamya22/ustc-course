import socket
import threading
import signal
import sys
import time

clients = []  # 用于存储所有连接的客户端
server_socket = None  # 服务器的套接字

def broadcast(message):
    """向所有客户端广播消息"""
    for client in clients:
        try:
            client.send(message)
        except:
            clients.remove(client)

def handle_client(client_socket):
    """处理单个客户端的消息"""
    while True:
        try:
            message = client_socket.recv(1024)
            if not message:
                break
            broadcast(message)
        except:
            break
    clients.remove(client_socket)
    client_socket.close()

def accept_clients():
    """接受新的客户端连接"""
    while True:
        try:
            client_socket, addr = server_socket.accept()
            print(f"New connection from {addr}")
            clients.append(client_socket)
            threading.Thread(target=handle_client, args=(client_socket,), daemon=True).start()
        except:
            break
def shutdown_server(signum, frame):
    """捕获终止信号并关闭服务器"""
    print(f"\nSignal {signum} received, shutting down server...")
    # 向所有客户端广播服务器关闭信息
    broadcast("Server is shutting down.".encode('utf-8'))
    # 关闭所有客户端连接
    for client in clients:
        client.close()
    server_socket.close()
    sys.exit(0)
def start_server(host='127.0.0.1', port=12345):
    global server_socket
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(5)
    print(f"Server started on {host}:{port}")

    # def accept_clients():
    #     """接受新的客户端连接"""
    #     while True:
    #         try:
    #             client_socket, addr = server_socket.accept()
    #             print(f"New connection from {addr}")
    #             clients.append(client_socket)
    #             threading.Thread(target=handle_client, args=(client_socket,), daemon=True).start()
    #         except:
    #             break

    # 启动接收客户端连接的线程
    accept_thread = threading.Thread(target=accept_clients, daemon=True)
    accept_thread.start()

    # def shutdown_server(signum, frame):
    #     """捕获终止信号并关闭服务器"""
    #     print(f"\nSignal {signum} received, shutting down server...")
    #     # 向所有客户端广播服务器关闭信息
    #     broadcast("Server is shutting down.".encode('utf-8'))
    #     # 关闭所有客户端连接
    #     for client in clients:
    #         client.close()
    #     server_socket.close()
    #     sys.exit(0)

    # 注册 SIGINT（Ctrl+C）信号处理
    signal.signal(signal.SIGINT, shutdown_server)
    signal.signal(signal.SIGTERM, shutdown_server)

    print("Server is running. Press Ctrl+C to stop.")
    while True:
        try:
            # 主线程等待信号
            time.sleep(1) # 等待信号到来
        except KeyboardInterrupt:
            pass

if __name__ == "__main__":
    start_server()
