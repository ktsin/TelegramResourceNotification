// See https://aka.ms/new-console-template for more information

using System.Net;
using System.Net.Sockets;

Console.WriteLine("Hello, World!");

TcpListener listener = new TcpListener(IPAddress.Any, 6000);
listener.Start();

while (true)
{
    var client = listener.AcceptTcpClient();
    Console.WriteLine(DateTime.Now);
    Thread.Sleep(1000*30);
    client.Close();
}


