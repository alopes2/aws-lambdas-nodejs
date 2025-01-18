import type { Context, SNSEvent, SQSEvent } from 'aws-lambda';

export const handler = async (event: SNSEvent | SQSEvent, context: Context) => {
  console.log('Received event ', event);

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Hello from lambda!',
    }),
  };
};
