import socket
import os, os.path
import time   
import struct
import sys

def pack_all(lst):
    fmt = ''.join('i' if isinstance(x, int) else 'f' for x in lst)
    return struct.pack(fmt, *lst)

while True:
  if os.path.exists("/tmp/displaysSocket"):
    os.remove("/tmp/displaysSocket")    

  server = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
  server.bind("/tmp/displaysSocket")

  print("Listening now...")
  print("Sys byte order is", sys.byteorder)

  server.listen(1)
  conn,addr = server.accept()

  while True:
    try:
      id_ = int(input("Enter id value: "))
      value_ = float(input("enter float value: "))
    except ValueError:
      continue
    id = bytearray(struct.pack('>i', id_))
    f = bytearray(struct.pack('>f', value_))
    try: 
      conn.send(id)
      conn.send(f)
    except:
      print("Pipe broken!")
      break



