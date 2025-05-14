
using Amazon.Lambda.Core;
using Amazon.Lambda.Serialization.SystemTextJson;
using Amazon.Lambda.APIGatewayEvents;
using Amazon.SimpleNotificationService.Model;
using Amazon.SimpleNotificationService;
using System.Text.Json;
using Domain.DTO;

[assembly: LambdaSerializer(typeof(DefaultLambdaJsonSerializer))]
namespace PublishToSns;

public class FunctionHandler
{
    private readonly IAmazonSimpleNotificationService _snsClient;
    private readonly string? _topicArn = Environment.GetEnvironmentVariable("TOPIC_ARN");

    public FunctionHandler() => _snsClient = new AmazonSimpleNotificationServiceClient();

    public async Task<APIGatewayProxyResponse> Handle(APIGatewayProxyRequest request, ILambdaContext context)
    {
        var input = JsonSerializer.Deserialize<DeviceNotification>(request.Body!);

        var message = JsonSerializer.Serialize(input);

        var response = await _snsClient.PublishAsync(new PublishRequest
        {
            TopicArn = _topicArn,
            Message = message
        });

        return new APIGatewayProxyResponse
        {
            StatusCode = 200,
            Body = JsonSerializer.Serialize(new { MessageId = response.MessageId })
        };
    }

}
