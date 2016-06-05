#!/usr/bin/env python
import select, argparse, socket
from subprocess import Popen
    
def server_socket(ip, port):
    serv = socket.socket()
    try:
        serv.bind((ip, port))
    except:
        if (ip != ''):
            print("Failed to bind to " + ip + " on port " + str(port) + " exiting" )
        else:
            print("Failed to bind to all on port " + str(port) + " exiting" )
        exit()

    if (ip != ''):
        print("Bound to " + ip + " on port " + str(port) + " echoing tcp" )
    else:
        print("Bound to all on port " + str(port) + " echoing tcp" )

    serv.listen(1)
    inputlist = [serv,]

    while 1:
        inputready,_,_ = select.select(inputlist,[],[], 3)

        if not inputready:
            for i in inputlist:
                if i != serv:
                    i.close()
                    inputlist.remove(i)
                    print("connection timeout")

        for i in inputready:
            if i == serv:
                client, address = serv.accept()
                inputlist.append(client)
                print("connection open from " + str(address))
            else:
                try:
                    data = i.recv(1024)
                    print("received " + str(len(data)) + " bytes"),
                    print(" \""+ data +"\"")
                    if len(data)>0:
                        Popen(["add_and_play.pl",data])
                    if data:
                        i.send(data)
                    else:
                        i.close()
                        inputlist.remove(i)
                        print("connection closed")
                except:
                    i.close()
                    inputlist.remove(i)
                    print("connection closed")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog = "TCP Echo server")

    parser.add_argument('-i', '--ip', type=str, default='', help = "IP to bind to")
    parser.add_argument('port', type=int, help = "Port to bind to")

    args = parser.parse_args()
    server_socket(args.ip, args.port)
