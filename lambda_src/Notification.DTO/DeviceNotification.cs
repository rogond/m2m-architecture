namespace Domain.DTO;

public class DeviceNotification
{
    public string DeviceId { get; set; } = string.Empty;
    public string NotificationType { get; set; } = string.Empty;
    public string NotificationMessage { get; set; } = string.Empty;
}
