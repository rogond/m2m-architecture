using Amazon.Lambda.Core;
using Amazon.Lambda.Serialization.SystemTextJson;
using Amazon.Lambda.SQSEvents;

[assembly: LambdaSerializer(typeof(DefaultLambdaJsonSerializer))]
namespace Function3;

public class FunctionHandler
{
    public async Task Handle(SQSEvent sqsEvent, ILambdaContext context)
    {
        foreach (var record in sqsEvent.Records)
        {
            context.Logger.LogLine($"[Lambda] Message 3: {record.Body}");
        }

        await Task.CompletedTask;
    }
}
