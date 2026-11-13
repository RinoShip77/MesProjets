using System.Net;
using System.Net.Sockets;
using System.Text;

namespace GrindWall.Services;

/// <summary>
/// Service that handles bidirectional network communication for syncing squat count
/// </summary>
public class NetworkSyncService : IDisposable
{
    private TcpListener? _listener;
    private CancellationTokenSource? _listenerCts;
    private readonly int _port = 5000;
    
    public event EventHandler<int>? SquatCountReceived;
    public event EventHandler<string>? CommandReceived;

    public async Task StartListeningAsync()
    {
        try
        {
            _listenerCts = new CancellationTokenSource();
            _listener = new TcpListener(IPAddress.Any, _port);
            _listener.Start();
            
            System.Diagnostics.Debug.WriteLine($"[NetworkSync] Listening on port {_port}");

            while (!_listenerCts.Token.IsCancellationRequested)
            {
                try
                {
                    var client = await _listener.AcceptTcpClientAsync(_listenerCts.Token);
                    _ = Task.Run(async () => await HandleClientAsync(client), _listenerCts.Token);
                }
                catch (OperationCanceledException)
                {
                    break;
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"[NetworkSync] Accept error: {ex.Message}");
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[NetworkSync] Listen error: {ex.Message}");
        }
    }

    private async Task HandleClientAsync(TcpClient client)
    {
        try
        {
            using (client)
            using (NetworkStream stream = client.GetStream())
            {
                byte[] buffer = new byte[1024];
                int bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length);
                string message = Encoding.UTF8.GetString(buffer, 0, bytesRead).Trim();

                System.Diagnostics.Debug.WriteLine($"[NetworkSync] Received: {message}");

                // Parse message
                if (message.StartsWith("SQUAT_UPDATE:"))
                {
                    if (int.TryParse(message.Substring("SQUAT_UPDATE:".Length), out int count))
                    {
                        SquatCountReceived?.Invoke(this, count);
                    }
                }
                else
                {
                    CommandReceived?.Invoke(this, message);
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[NetworkSync] Handle client error: {ex.Message}");
        }
    }

    public async Task SendSquatUpdateAsync(string ipAddress, int count)
    {
        try
        {
            using var client = new TcpClient();
            var connectTask = client.ConnectAsync(ipAddress, _port);
            
            if (await Task.WhenAny(connectTask, Task.Delay(1000)) != connectTask)
            {
                System.Diagnostics.Debug.WriteLine($"[NetworkSync] Send timeout to {ipAddress}");
                return;
            }

            using NetworkStream stream = client.GetStream();
            string message = $"SQUAT_UPDATE:{count}";
            byte[] data = Encoding.UTF8.GetBytes(message);
            await stream.WriteAsync(data, 0, data.Length);
            
            System.Diagnostics.Debug.WriteLine($"[NetworkSync] Sent: {message} to {ipAddress}");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[NetworkSync] Send error: {ex.Message}");
        }
    }

    public async Task SendResetAsync(string ipAddress)
    {
        try
        {
            using var client = new TcpClient();
            var connectTask = client.ConnectAsync(ipAddress, _port);
            
            if (await Task.WhenAny(connectTask, Task.Delay(1000)) != connectTask)
            {
                System.Diagnostics.Debug.WriteLine($"[NetworkSync] Reset send timeout to {ipAddress}");
                return;
            }

            using NetworkStream stream = client.GetStream();
            string message = "RESET_COUNTER";
            byte[] data = Encoding.UTF8.GetBytes(message);
            await stream.WriteAsync(data, 0, data.Length);
            
            System.Diagnostics.Debug.WriteLine($"[NetworkSync] Sent: {message} to {ipAddress}");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"[NetworkSync] Reset send error: {ex.Message}");
        }
    }

    public void StopListening()
    {
        _listenerCts?.Cancel();
        _listener?.Stop();
        System.Diagnostics.Debug.WriteLine("[NetworkSync] Stopped listening");
    }

    public void Dispose()
    {
        StopListening();
        _listenerCts?.Dispose();
        _listener?.Dispose();
    }
}
